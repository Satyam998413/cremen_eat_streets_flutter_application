import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/error/result.dart';
import '../../../../core/pricing/wholesale_fee_calculator.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/wholesale_delivery_banner.dart';
import '../../../auth/domain/entities/account_role.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../b2b/presentation/bloc/sales_wholesaler_cubit.dart';
import '../../../b2b/presentation/screens/wholesaler_picker_sheet.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../../../orders/domain/entities/food_order.dart';
import '../../domain/usecases/reverse_geocode_usecase.dart';
import '../bloc/checkout_bloc.dart';
import '../bloc/checkout_event.dart';
import '../bloc/checkout_state.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _notesController = TextEditingController();
  OrderType _orderType = OrderType.pickup;
  bool _noReturnAck = false;
  bool _locating = false;
  String? _locationError;
  late final Razorpay _razorpay;
  final _locationService = getIt<LocationService>();

  /// 'razorpay' | 'cod' — only ever surfaced/used for a B2B (sales/wholesale)
  /// order; a retail order always pays via Razorpay, same as before this
  /// channel existed.
  String _paymentMethod = 'razorpay';

  /// A salesman's own "ordering for" selection — this single app-scoped
  /// cubit is shared with the B2B catalog screen, so a choice made there
  /// already carries over here with no navigation-argument plumbing.
  /// Irrelevant for a customer or wholesaler account (a wholesaler always
  /// orders for themselves).
  final _salesWholesalerCubit = getIt<SalesWholesalerCubit>();

  // razorpay_flutter only ships a native Android/iOS implementation — on
  // every other platform there is no MethodChannel to answer `open()`, so we
  // never attempt the call there at all rather than risk an unhandled
  // platform-channel exception.
  bool get _supportsRazorpay =>
      defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _onExternalWallet);

    // `context.read` (not `watch`) is safe in initState — the MultiBlocProvider
    // ancestor is already mounted by the time this screen is pushed. Only
    // triggers a reload if nothing's loaded yet: the B2B catalog screen this
    // is normally reached from already primed the same singleton cubit.
    final authState = context.read<AuthBloc>().state;
    if (authState case Authenticated(role: AccountRole.salesman, profile: final profile)) {
      if (_salesWholesalerCubit.state.wholesalers.isEmpty && !_salesWholesalerCubit.state.isLoading) {
        _salesWholesalerCubit.loadFor(profile.id);
      }
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _line1Controller.dispose();
    _line2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onPaymentSuccess(PaymentSuccessResponse response) {
    context
        .read<CheckoutBloc>()
        .add(CheckoutEvent.paymentSucceeded(response.paymentId ?? '', response.signature ?? ''));
  }

  void _onPaymentError(PaymentFailureResponse response) {
    context.read<CheckoutBloc>().add(CheckoutEvent.paymentFailed(response.message ?? 'Payment was cancelled.'));
  }

  void _onExternalWallet(ExternalWalletResponse response) {}

  void _openRazorpay(CheckoutAwaitingPayment state) {
    if (!_supportsRazorpay) {
      context.read<CheckoutBloc>().add(
            const CheckoutEvent.paymentFailed('Payment is only available on the Android and iOS apps.'),
          );
      return;
    }
    _razorpay.open({
      'key': state.keyId,
      'amount': state.amount,
      'currency': state.currency,
      'name': 'Cremen Eat Streets',
      'order_id': state.razorpayOrderId,
      'prefill': {
        'contact': state.prefillContact,
        if (state.prefillEmail != null && state.prefillEmail!.isNotEmpty) 'email': state.prefillEmail,
      },
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final role = authState is Authenticated ? authState.role : AccountRole.customer;
    final channel = role.orderChannel;
    final isB2B = channel != 'retail';

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CheckoutBloc, CheckoutState>(
            listener: (context, state) {
              switch (state) {
                case CheckoutAwaitingPayment():
                  _openRazorpay(state);
                case CheckoutFailure(:final message):
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                case CheckoutSuccess(:final publicToken):
                  _onCheckoutSuccess(context, publicToken);
                default:
                  break;
              }
            },
          ),
        ],
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            final showAddressFields = isB2B || _orderType == OrderType.delivery;
            final deliveryFee = isB2B
                ? WholesaleFeeCalculator.calcDeliveryFee(cartState.items.map((i) => i.quantity))
                : (_orderType == OrderType.delivery ? 20.0 : 0.0);
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isB2B) ...[
                      if (role == AccountRole.salesman) ...[
                        WholesalerBanner(cubit: _salesWholesalerCubit),
                        const SizedBox(height: 12),
                      ],
                      WholesaleDeliveryBanner(
                        packetCount: WholesaleFeeCalculator.calcPacketCount(cartState.items.map((i) => i.quantity)),
                      ),
                      const SizedBox(height: 20),
                    ],
                    if (!isB2B) ...[
                      const Text('Order Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ChoiceChip(
                              label: const Center(child: Text('Pickup')),
                              selected: _orderType == OrderType.pickup,
                              selectedColor: AppColors.brandPrimary,
                              onSelected: (v) {
                                if (v) setState(() => _orderType = OrderType.pickup);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ChoiceChip(
                              label: const Center(child: Text('Direct Delivery')),
                              selected: _orderType == OrderType.delivery,
                              selectedColor: AppColors.brandPrimary,
                              onSelected: (v) {
                                if (v) setState(() => _orderType = OrderType.delivery);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Your Name'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(labelText: 'Phone Number'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email (optional)'),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      alignment: Alignment.topCenter,
                      child: showAddressFields
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Delivery Address in Surat',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    TextButton.icon(
                                      onPressed: _locating ? null : _useCurrentLocation,
                                      icon: AnimatedSwitcher(
                                        duration: const Duration(milliseconds: 200),
                                        child: _locating
                                            ? const SizedBox(
                                                key: ValueKey('locating'),
                                                width: 14,
                                                height: 14,
                                                child: CircularProgressIndicator(strokeWidth: 2),
                                              )
                                            : const Icon(Icons.my_location, size: 16, key: ValueKey('locate-icon')),
                                      ),
                                      label: Text(_locating ? 'Locating…' : 'Use current location'),
                                    ),
                                  ],
                                ),
                                if (_locationError != null) ...[
                                  const SizedBox(height: 4),
                                  Text(_locationError!, style: const TextStyle(color: AppColors.spicyRed, fontSize: 12)),
                                ],
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _line1Controller,
                                  decoration: const InputDecoration(labelText: 'Address line 1'),
                                ),
                                const SizedBox(height: 12),
                                TextField(
                                  controller: _line2Controller,
                                  decoration: const InputDecoration(labelText: 'Address line 2 (optional)'),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _cityController,
                                        decoration: const InputDecoration(labelText: 'City'),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextField(
                                        controller: _stateController,
                                        decoration: const InputDecoration(labelText: 'State'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                TextField(
                                  controller: _pincodeController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(labelText: 'Pincode'),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _notesController,
                      maxLines: 2,
                      decoration: const InputDecoration(labelText: 'Order notes (optional)'),
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _noReturnAck,
                      onChanged: (v) => setState(() => _noReturnAck = v ?? false),
                      title: const Text('I understand this order cannot be returned or refunded.'),
                    ),
                    if (isB2B) ...[
                      const SizedBox(height: 4),
                      const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ChoiceChip(
                              label: const Center(child: Text('Pay Online')),
                              selected: _paymentMethod == 'razorpay',
                              selectedColor: AppColors.brandPrimary,
                              onSelected: (v) {
                                if (v) setState(() => _paymentMethod = 'razorpay');
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ChoiceChip(
                              label: const Center(child: Text('Cash on Delivery')),
                              selected: _paymentMethod == 'cod',
                              selectedColor: AppColors.brandPrimary,
                              onSelected: (v) {
                                if (v) setState(() => _paymentMethod = 'cod');
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.cardBorder),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Subtotal'),
                              Text('₹${cartState.totalAmount.toStringAsFixed(0)}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Delivery Fee'),
                              Text(deliveryFee > 0 ? '₹${deliveryFee.toStringAsFixed(0)}' : 'FREE'),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                '₹${(cartState.totalAmount + deliveryFee).toStringAsFixed(0)}',
                                style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.brandPrimary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<CheckoutBloc, CheckoutState>(
                      builder: (context, checkoutState) {
                        final isBusy =
                            checkoutState is CheckoutCreatingOrder || checkoutState is CheckoutVerifyingPayment;
                        return AppButton(
                          label: isB2B && _paymentMethod == 'cod' ? 'Place Order' : 'Pay Now',
                          isLoading: isBusy,
                          onPressed: () => _submit(context, cartState, role: role, channel: channel, isB2B: isB2B),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submit(
    BuildContext context,
    CartState cartState, {
    required AccountRole role,
    required String channel,
    required bool isB2B,
  }) {
    if (cartState.items.isEmpty) return;
    if (_nameController.text.trim().isEmpty || _phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name and phone number.')),
      );
      return;
    }
    if (!_noReturnAck) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please acknowledge the no-return policy.')),
      );
      return;
    }
    String? wholesalerId;
    if (role == AccountRole.salesman) {
      wholesalerId = _salesWholesalerCubit.state.selected?.id;
      if (wholesalerId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select which wholesaler you are ordering for.')),
        );
        return;
      }
    }
    // B2B orders always ship (no pickup/local-delivery option), so the
    // address block is required the same way retail's delivery path is.
    final requiresAddress = isB2B || _orderType == OrderType.delivery;
    Map<String, dynamic>? shippingAddress;
    if (requiresAddress) {
      if (_line1Controller.text.trim().isEmpty ||
          _cityController.text.trim().isEmpty ||
          _stateController.text.trim().isEmpty ||
          _pincodeController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in your full delivery address.')),
        );
        return;
      }
      shippingAddress = {
        'line1': _line1Controller.text.trim(),
        'line2': _line2Controller.text.trim(),
        'city': _cityController.text.trim(),
        'state': _stateController.text.trim(),
        'pincode': _pincodeController.text.trim(),
      };
    }
    context.read<CheckoutBloc>().add(CheckoutEvent.submitted(
          items: cartState.items,
          fulfillmentType:
              isB2B ? 'shipping' : (_orderType == OrderType.delivery ? 'local_delivery' : 'pickup'),
          customerName: _nameController.text.trim(),
          customerPhone: _phoneController.text.trim(),
          noReturnAck: _noReturnAck,
          customerEmail: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
          shippingAddress: shippingAddress,
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
          channel: channel,
          paymentMethod: isB2B ? _paymentMethod : 'razorpay',
          wholesalerId: wholesalerId,
        ));
  }

  Future<void> _useCurrentLocation() async {
    setState(() {
      _locating = true;
      _locationError = null;
    });

    final positionResult = await _locationService.getCurrentPosition();
    if (!mounted) return;

    switch (positionResult) {
      case Failed(:final failure):
        setState(() {
          _locating = false;
          _locationError = failure.message;
        });
        return;
      case Success(:final value):
        final geocodeResult = await getIt<ReverseGeocodeUseCase>().call(
              ReverseGeocodeParams(lat: value.latitude, lon: value.longitude),
            );
        if (!mounted) return;
        switch (geocodeResult) {
          case Failed(:final failure):
            setState(() {
              _locating = false;
              _locationError = failure.message;
            });
          case Success(:final value):
            setState(() {
              _locating = false;
              if (value.line1.isNotEmpty) _line1Controller.text = value.line1;
              if (value.city.isNotEmpty) _cityController.text = value.city;
              if (value.state.isNotEmpty) _stateController.text = value.state;
              if (value.pincode.isNotEmpty) _pincodeController.text = value.pincode;
            });
        }
    }
  }

  void _onCheckoutSuccess(BuildContext context, String publicToken) {
    // The order already exists server-side (confirmed by this success) —
    // Order Tracking fetches it for itself by public_token, so there's
    // nothing to mirror locally here.
    context.read<CartBloc>().add(CartCleared());
    context.go('/orders/$publicToken');
  }
}
