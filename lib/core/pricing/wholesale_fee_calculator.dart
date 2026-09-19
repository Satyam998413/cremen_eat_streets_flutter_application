/// A faithful Dart port of `app/lib/wholesale.js` (cremen_eat_streets) — the
/// flat B2B delivery-fee rule already shipped on the web app. This is
/// specific to the `sales`/`wholesale` order channels; it does not combine
/// with or replace the retail delivery-fee preview (flat ₹20/pickup-free),
/// which stays untouched for a customer-channel order.
class WholesaleFeeCalculator {
  const WholesaleFeeCalculator._();

  static const int minPackets = 20;
  static const double underMinDeliveryFee = 60;

  /// Mirrors `calcWholesalePacketCount(items)` — one "packet" per unit of
  /// quantity across every line, regardless of product/variant.
  static int calcPacketCount(Iterable<int> quantities) {
    return quantities.fold(0, (sum, quantity) => sum + quantity);
  }

  /// Mirrors `calcWholesaleDeliveryFee(items)`.
  static double calcDeliveryFee(Iterable<int> quantities) {
    return calcPacketCount(quantities) >= minPackets ? 0 : underMinDeliveryFee;
  }
}
