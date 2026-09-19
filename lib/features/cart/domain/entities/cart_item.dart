import 'package:equatable/equatable.dart';
import '../../../../core/pricing/pricing_resolver.dart';
import '../../../catalog/domain/entities/product.dart';

class CartItem extends Equatable {
  final String id;
  final Product product;
  final int quantity;

  /// Matches a `product.variants[].label` when the product has variants
  /// (e.g. a pack size/flavor) — null for a product with no variants. This is
  /// the only per-line customization the real `order_items` schema supports
  /// (see plans/platform-overview.md, cremen_eat_streets, Step 4a); there is
  /// no spice-level/extra-cheese/instructions column to persist those against.
  final String? variantLabel;

  /// A snapshot of the pricing tier active at the moment this line was added
  /// to the cart — always [PricingTier.retail] for an ordinary customer
  /// (identical to this app's pricing before the B2B channel existed).
  /// Snapshotting rather than re-resolving live from the current account on
  /// every read keeps a cart line's price stable for the rest of that
  /// checkout even if role resolution is still in flight when the item was
  /// added; there's no real-world path today where the same cart is carried
  /// across two different account roles anyway (cart isn't server-synced).
  final PricingTier pricingTier;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    this.variantLabel,
    this.pricingTier = PricingTier.retail,
  });

  double get unitPrice {
    return PricingResolver.resolveUnitPrice(product, variantLabel: variantLabel, tier: pricingTier) ??
        product.basePrice;
  }

  double get totalPrice => unitPrice * quantity;

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    String? variantLabel,
    PricingTier? pricingTier,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      variantLabel: variantLabel ?? this.variantLabel,
      pricingTier: pricingTier ?? this.pricingTier,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toMap(),
      'quantity': quantity,
      'variantLabel': variantLabel,
      'pricingTier': pricingTier.name,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      product: Product.fromMap(Map<String, dynamic>.from(map['product'] as Map)),
      quantity: map['quantity'] as int,
      variantLabel: map['variantLabel'] as String?,
      // Absent for any cart persisted before this field existed — defaults
      // to retail, matching that cart's only possible pricing at the time.
      pricingTier: PricingTier.values.asNameMap()[map['pricingTier'] as String?] ?? PricingTier.retail,
    );
  }

  @override
  List<Object?> get props => [id, product, quantity, variantLabel, pricingTier];
}
