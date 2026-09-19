import '../../../../core/error/result.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../entities/created_order.dart';
import '../entities/resolved_address.dart';

abstract class CheckoutRepository {
  /// Reverse-geocodes a device coordinate into a fillable street address —
  /// proxied server-side (see cremen_eat_streets `/api/geocode/reverse`) so
  /// the OpenStreetMap Nominatim User-Agent requirement is met without the
  /// app needing to know about it.
  Future<Result<ResolvedAddress>> reverseGeocode({required double lat, required double lon});

  /// Server re-prices every line and re-validates fulfillment/shipping rules
  /// — never trust the client-side total (see plans/platform-overview.md,
  /// cremen_eat_streets, Step 10).
  ///
  /// [channel]/[paymentMethod]/[wholesalerId] only affect the request payload
  /// (and thus server behavior) when [channel] isn't `'retail'` — a retail
  /// order's payload is byte-for-byte identical to what this app sent before
  /// the B2B ordering channel existed.
  Future<Result<CreatedOrder>> createOrder({
    required List<CartItem> items,
    required String fulfillmentType,
    required String customerName,
    required String customerPhone,
    required bool noReturnAck,
    String? customerEmail,
    Map<String, dynamic>? shippingAddress,
    String? notes,
    String channel = 'retail',
    String paymentMethod = 'razorpay',
    String? wholesalerId,
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
