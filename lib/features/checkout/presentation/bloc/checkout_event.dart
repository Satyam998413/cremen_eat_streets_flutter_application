import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../cart/domain/entities/cart_item.dart';

part 'checkout_event.freezed.dart';

@freezed
sealed class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.submitted({
    required List<CartItem> items,
    required String fulfillmentType,
    required String customerName,
    required String customerPhone,
    required bool noReturnAck,
    String? customerEmail,
    Map<String, dynamic>? shippingAddress,
    String? notes,
    @Default('retail') String channel,
    @Default('razorpay') String paymentMethod,
    String? wholesalerId,
  }) = CheckoutSubmitted;

  const factory CheckoutEvent.paymentSucceeded(String razorpayPaymentId, String razorpaySignature) =
      CheckoutPaymentSucceeded;

  const factory CheckoutEvent.paymentFailed(String message) = CheckoutPaymentFailed;
}
