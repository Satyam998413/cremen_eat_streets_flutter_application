import '../../features/catalog/domain/entities/product.dart';

/// Which price list applies to the account viewing/ordering right now.
/// Mirrors `PRICING_TIERS` from `app/lib/pricing.js` (cremen_eat_streets) —
/// 'retail' is every ordinary customer; 'wholesale' is a signed-in
/// salesman or wholesaler account (see AccountRole.pricingTier).
enum PricingTier { retail, wholesale }

/// A faithful Dart port of `app/lib/pricing.js` (cremen_eat_streets) — the
/// exact price-resolution rules already shipped on the web app. Keep this in
/// lockstep with that file; do not "improve" the logic here independently of
/// the web source of truth.
class PricingResolver {
  const PricingResolver._();

  /// Mirrors `resolveCompareAtPrice(product, variantLabel)`.
  ///
  /// The web version also checks a per-variant `compareAtPrice` key
  /// (`variant?.compareAtPrice ?? product.compare_at_price ?? null`), but no
  /// such key exists in this app's `ProductVariant` model or in the
  /// `variants` jsonb contract this feature introduces (only `wholesalePrice`
  /// was added there) — so that branch is always a no-op today and is
  /// deliberately omitted rather than modeling a field that's never set.
  /// The packet MRP this resolves to is shown struck-through for comparison
  /// regardless of pricing tier: it is never itself charged to anyone,
  /// retail or wholesale.
  static double? resolveCompareAtPrice(Product product, {String? variantLabel}) {
    return product.compareAtPrice;
  }

  /// Mirrors `resolveUnitPrice(product, variantLabel, tier)`.
  static double? resolveUnitPrice(
    Product product, {
    String? variantLabel,
    PricingTier tier = PricingTier.retail,
  }) {
    final isWholesale = tier == PricingTier.wholesale;
    if (variantLabel != null) {
      final variant = _findVariant(product, variantLabel);
      if (variant == null) return null;
      return isWholesale ? (variant.wholesalePrice ?? variant.price) : variant.price;
    }
    return isWholesale ? (product.wholesalePrice ?? product.basePrice) : product.basePrice;
  }

  /// Mirrors `discountPercent(unitPrice, compareAtPrice)`.
  static int? discountPercent(double unitPrice, double? compareAtPrice) {
    if (compareAtPrice == null || compareAtPrice <= unitPrice) return null;
    return (((compareAtPrice - unitPrice) / compareAtPrice) * 100).round();
  }

  static ProductVariant? _findVariant(Product product, String label) {
    for (final variant in product.variants) {
      if (variant.label == label) return variant;
    }
    return null;
  }
}
