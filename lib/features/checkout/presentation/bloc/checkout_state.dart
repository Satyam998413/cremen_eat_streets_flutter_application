import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_state.freezed.dart';

@freezed
sealed class CheckoutState with _$CheckoutState {
  const factory CheckoutState.idle() = CheckoutIdle;
  const factory CheckoutState.creatingOrder() = CheckoutCreatingOrder;
  const factory CheckoutState.awaitingPayment({
    required String orderId,
    required String razorpayOrderId,
    required int amount,
    required String currency,
    required String keyId,
    required String prefillName,
    required String prefillContact,
    String? prefillEmail,
  }) = CheckoutAwaitingPayment;
  const factory CheckoutState.verifyingPayment() = CheckoutVerifyingPayment;
  const factory CheckoutState.success(String publicToken) = CheckoutSuccess;
  const factory CheckoutState.failure(String message) = CheckoutFailure;
}
