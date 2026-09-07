import 'package:equatable/equatable.dart';

/// A historical line item as the server recorded it — mirrors `order_items`
/// exactly (see plans/platform-overview.md, cremen_eat_streets, Step 4a).
/// Deliberately NOT the same type as the local cart's `CartItem`: an order
/// snapshot only ever keeps `product_name`/`unit_price` at time of purchase,
/// never a live `Product` reference (a product can change or be deleted
/// after the order is placed without altering this history).
class OrderLineItem extends Equatable {
  const OrderLineItem({
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.lineTotal,
    this.productId,
    this.variantLabel,
  });

  final String? productId;
  final String productName;
  final String? variantLabel;
  final double unitPrice;
  final int quantity;
  final double lineTotal;

  @override
  List<Object?> get props => [productId, productName, variantLabel, unitPrice, quantity, lineTotal];
}
