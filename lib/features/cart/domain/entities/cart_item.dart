import 'package:equatable/equatable.dart';
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

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    this.variantLabel,
  });

  double get unitPrice {
    if (variantLabel != null) {
      for (final variant in product.variants) {
        if (variant.label == variantLabel) return variant.price;
      }
    }
    return product.basePrice;
  }

  double get totalPrice => unitPrice * quantity;

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    String? variantLabel,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      variantLabel: variantLabel ?? this.variantLabel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toMap(),
      'quantity': quantity,
      'variantLabel': variantLabel,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      product: Product.fromMap(Map<String, dynamic>.from(map['product'] as Map)),
      quantity: map['quantity'] as int,
      variantLabel: map['variantLabel'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, product, quantity, variantLabel];
}
