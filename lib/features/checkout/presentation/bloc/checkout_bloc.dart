import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../domain/usecases/create_order_usecase.dart';
import '../../domain/usecases/verify_payment_usecase.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

/// `@injectable` (not a singleton) — every checkout session (one push of
/// `/checkout`) needs its own fresh instance, never a bloc reused/reset
/// across two different checkout attempts.
@injectable
class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc({
    required CreateOrderUseCase createOrder,
    required VerifyPaymentUseCase verifyPayment,
  })  : _createOrder = createOrder,
        _verifyPayment = verifyPayment,
        super(const CheckoutState.idle()) {
    on<CheckoutSubmitted>(_onSubmitted);
    on<CheckoutPaymentSucceeded>(_onPaymentSucceeded);
    on<CheckoutPaymentFailed>(_onPaymentFailed);
  }

  final CreateOrderUseCase _createOrder;
  final VerifyPaymentUseCase _verifyPayment;

  Future<void> _onSubmitted(CheckoutSubmitted event, Emitter<CheckoutState> emit) async {
    emit(const CheckoutState.creatingOrder());
    final result = await _createOrder(CreateOrderParams(
      items: event.items,
      fulfillmentType: event.fulfillmentType,
      customerName: event.customerName,
      customerPhone: event.customerPhone,
      noReturnAck: event.noReturnAck,
      customerEmail: event.customerEmail,
      shippingAddress: event.shippingAddress,
      notes: event.notes,
      channel: event.channel,
      paymentMethod: event.paymentMethod,
      wholesalerId: event.wholesalerId,
    ));
    switch (result) {
      case Success(:final value):
        if (value.codConfirmed) {
          // Already confirmed server-side — nothing left to pay online, so
          // skip straight to the same success path a verified Razorpay
          // payment lands on.
          emit(CheckoutState.success(value.publicToken ?? ''));
        } else {
          emit(CheckoutState.awaitingPayment(
            orderId: value.orderId,
            razorpayOrderId: value.razorpayOrderId ?? '',
            amount: value.amount ?? 0,
            currency: value.currency ?? 'INR',
            keyId: value.keyId ?? '',
            prefillName: value.prefillName ?? event.customerName,
            prefillContact: value.prefillContact ?? event.customerPhone,
            prefillEmail: value.prefillEmail,
          ));
        }
      case Failed(:final failure):
        emit(CheckoutState.failure(failure.message));
    }
  }

  Future<void> _onPaymentSucceeded(CheckoutPaymentSucceeded event, Emitter<CheckoutState> emit) async {
    final current = state;
    if (current is! CheckoutAwaitingPayment) return;
    emit(const CheckoutState.verifyingPayment());
    final result = await _verifyPayment(VerifyPaymentParams(
      orderId: current.orderId,
      razorpayOrderId: current.razorpayOrderId,
      razorpayPaymentId: event.razorpayPaymentId,
      razorpaySignature: event.razorpaySignature,
    ));
    switch (result) {
      case Success(:final value):
        emit(CheckoutState.success(value));
      case Failed(:final failure):
        // The order stays pending_payment server-side — the backend's own
        // 10-minute reconciliation cron (plans/platform-overview.md, Step 8)
        // catches a payment that actually succeeded on Razorpay's side but
        // whose verify call never completed, so no retry-polling is needed
        // here.
        emit(CheckoutState.failure(failure.message));
    }
  }

  void _onPaymentFailed(CheckoutPaymentFailed event, Emitter<CheckoutState> emit) {
    emit(CheckoutState.failure(event.message));
  }
}
