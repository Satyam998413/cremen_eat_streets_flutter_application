import 'package:equatable/equatable.dart';
import '../../../catalog/domain/entities/product.dart';

class CartItem extends Equatable {
  final String id;
  final Product product;
  final int quantity;
  final String spiceLevel; // 'Mild', 'Medium', 'Spicy'
  final bool hasExtraCheese;
  final String specialInstructions;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    this.spiceLevel = 'Medium',
    this.hasExtraCheese = false,
    this.specialInstructions = '',
  });

  double get unitPrice => product.price + (hasExtraCheese ? 15.0 : 0.0);
  double get totalPrice => unitPrice * quantity;

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    String? spiceLevel,
    bool? hasExtraCheese,
    String? specialInstructions,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      spiceLevel: spiceLevel ?? this.spiceLevel,
      hasExtraCheese: hasExtraCheese ?? this.hasExtraCheese,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  @override
  List<Object?> get props => [
        id,
        product,
        quantity,
        spiceLevel,
        hasExtraCheese,
        specialInstructions,
      ];
}
