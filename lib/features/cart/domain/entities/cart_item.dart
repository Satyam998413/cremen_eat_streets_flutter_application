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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product.toMap(),
      'quantity': quantity,
      'spiceLevel': spiceLevel,
      'hasExtraCheese': hasExtraCheese,
      'specialInstructions': specialInstructions,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
      spiceLevel: map['spiceLevel'] as String? ?? 'Medium',
      hasExtraCheese: map['hasExtraCheese'] as bool? ?? false,
      specialInstructions: map['specialInstructions'] as String? ?? '',
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
