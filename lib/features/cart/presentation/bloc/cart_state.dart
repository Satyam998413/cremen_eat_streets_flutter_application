import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount => items.fold(0.0, (sum, item) => sum + item.totalPrice);

  CartState copyWith({List<CartItem>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}
