import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../../../orders/domain/entities/food_order.dart';
import '../../../orders/presentation/bloc/order_bloc.dart';
import '../../../orders/presentation/bloc/order_event.dart';
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
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  OrderType _orderType = OrderType.pickup;
  bool _noReturnAck = false;
  late final Razorpay _razorpay;

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
  }

  @override
  void dispose() {
    _razorpay.clear();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
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
            final deliveryFee = _orderType == OrderType.delivery ? 20.0 : 0.0;
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                    if (_orderType == OrderType.delivery) ...[
                      const SizedBox(height: 12),
                      TextField(
                        controller: _addressController,
                        decoration: const InputDecoration(labelText: 'Delivery Address in Surat'),
                      ),
                    ],
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
                          label: 'Pay Now',
                          isLoading: isBusy,
                          onPressed: () => _submit(context, cartState),
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

  void _submit(BuildContext context, CartState cartState) {
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
    context.read<CheckoutBloc>().add(CheckoutEvent.submitted(
          items: cartState.items,
          fulfillmentType: _orderType == OrderType.delivery ? 'local_delivery' : 'pickup',
          customerName: _nameController.text.trim(),
          customerPhone: _phoneController.text.trim(),
          noReturnAck: _noReturnAck,
          customerEmail: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
          shippingAddress:
              _orderType == OrderType.delivery ? {'line1': _addressController.text.trim()} : null,
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
        ));
  }

  void _onCheckoutSuccess(BuildContext context, String publicToken) {
    final cartState = context.read<CartBloc>().state;
    final deliveryFee = _orderType == OrderType.delivery ? 20.0 : 0.0;
    // Interim local mirror so Order Tracking/History show something
    // meaningful until they're rewired onto Supabase directly (next slice) —
    // the real order already exists server-side, confirmed by this success.
    context.read<OrderBloc>().add(OrderPlaced(FoodOrder(
          id: publicToken,
          publicToken: publicToken,
          items: List.of(cartState.items),
          subtotal: cartState.totalAmount,
          shippingFee: deliveryFee,
          totalAmount: cartState.totalAmount + deliveryFee,
          status: OrderStatus.confirmed,
          orderType: _orderType,
          createdAt: DateTime.now(),
          customerName: _nameController.text.trim(),
          customerPhone: _phoneController.text.trim(),
          customerEmail: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
        )));
    context.read<CartBloc>().add(CartCleared());
    context.go('/orders/$publicToken');
  }
}
