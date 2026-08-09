import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>(_onCartItemAdded);
    on<CartItemRemoved>(_onCartItemRemoved);
    on<CartItemQuantityChanged>(_onCartItemQuantityChanged);
    on<CartCleared>(_onCartCleared);
  }

  void _onCartItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    final existingIndex = state.items.indexWhere(
      (item) => item.product.id == event.item.product.id &&
          item.spiceLevel == event.item.spiceLevel &&
          item.hasExtraCheese == event.item.hasExtraCheese,
    );

    if (existingIndex >= 0) {
      final updatedList = List<dynamic>.from(state.items);
      final existingItem = state.items[existingIndex];
      updatedList[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + event.item.quantity,
      );
      emit(state.copyWith(items: List.castFrom(updatedList)));
    } else {
      emit(state.copyWith(items: [...state.items, event.item]));
    }
  }

  void _onCartItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final updatedList = state.items.where((item) => item.id != event.itemId).toList();
    emit(state.copyWith(items: updatedList));
  }

  void _onCartItemQuantityChanged(
      CartItemQuantityChanged event, Emitter<CartState> emit) {
    final updatedItems = state.items.map((item) {
      if (item.id == event.itemId) {
        final newQuantity = item.quantity + event.delta;
        return newQuantity > 0 ? item.copyWith(quantity: newQuantity) : null;
      }
      return item;
    }).whereType<dynamic>().toList();

    emit(state.copyWith(items: List.castFrom(updatedItems)));
  }

  void _onCartCleared(CartCleared event, Emitter<CartState> emit) {
    emit(const CartState(items: []));
  }
}
