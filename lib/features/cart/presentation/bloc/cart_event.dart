import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartItemAdded extends CartEvent {
  final CartItem item;
  const CartItemAdded(this.item);

  @override
  List<Object?> get props => [item];
}

class CartItemRemoved extends CartEvent {
  final String itemId;
  const CartItemRemoved(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class CartItemQuantityChanged extends CartEvent {
  final String itemId;
  final int delta;
  const CartItemQuantityChanged(this.itemId, this.delta);

  @override
  List<Object?> get props => [itemId, delta];
}

class CartCleared extends CartEvent {}
