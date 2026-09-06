import '../../../../core/error/result.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../entities/created_order.dart';

abstract class CheckoutRepository {
  /// Server re-prices every line and re-validates fulfillment/shipping rules
  /// — never trust the client-side total (see plans/platform-overview.md,
  /// cremen_eat_streets, Step 10).
  Future<Result<CreatedOrder>> createOrder({
    required List<CartItem> items,
    required String fulfillmentType,
    required String customerName,
    required String customerPhone,
    required bool noReturnAck,
    String? customerEmail,
    Map<String, dynamic>? shippingAddress,
    String? notes,
  });

  /// Returns the order's public_token on success — the key for the
  /// order-tracking/receipt screen.
  Future<Result<String>> verifyPayment({
    required String orderId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  });
}
