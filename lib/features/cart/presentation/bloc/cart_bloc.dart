import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/hive_storage_service.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>(_onCartItemAdded);
    on<CartItemRemoved>(_onCartItemRemoved);
    on<CartItemQuantityChanged>(_onCartItemQuantityChanged);
    on<CartCleared>(_onCartCleared);
    _hydrateFromStorage();
  }

  Future<void> _hydrateFromStorage() async {
    final storedItems = await HiveStorageService.loadCartItems();
    if (storedItems.isNotEmpty) {
      emit(state.copyWith(items: storedItems));
    }
  }

  Future<void> _onCartItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    final existingIndex = state.items.indexWhere(
      (item) => item.product.id == event.item.product.id &&
          item.spiceLevel == event.item.spiceLevel &&
          item.hasExtraCheese == event.item.hasExtraCheese,
    );

    List<CartItem> updatedItems;
    if (existingIndex >= 0) {
      final updatedList = List<CartItem>.from(state.items);
      final existingItem = state.items[existingIndex];
      updatedList[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + event.item.quantity,
      );
      updatedItems = updatedList;
    } else {
      updatedItems = [...state.items, event.item];
    }

    emit(state.copyWith(items: updatedItems));
    await HiveStorageService.saveCartItems(updatedItems);
  }

  Future<void> _onCartItemRemoved(CartItemRemoved event, Emitter<CartState> emit) async {
    final updatedList = state.items.where((item) => item.id != event.itemId).toList();
    emit(state.copyWith(items: updatedList));
    await HiveStorageService.saveCartItems(updatedList);
  }

  Future<void> _onCartItemQuantityChanged(
      CartItemQuantityChanged event, Emitter<CartState> emit) async {
    final updatedItems = state.items.map((item) {
      if (item.id == event.itemId) {
        final newQuantity = item.quantity + event.delta;
        return newQuantity > 0 ? item.copyWith(quantity: newQuantity) : null;
      }
      return item;
    }).whereType<CartItem>().toList();

    emit(state.copyWith(items: updatedItems));
    await HiveStorageService.saveCartItems(updatedItems);
  }

  Future<void> _onCartCleared(CartCleared event, Emitter<CartState> emit) async {
    emit(const CartState(items: []));
    await HiveStorageService.saveCartItems(const []);
  }
}
