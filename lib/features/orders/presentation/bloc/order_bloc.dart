import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/hive_storage_service.dart';
import '../../domain/entities/food_order.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderState()) {
    on<OrderPlaced>(_onOrderPlaced);
    on<OrderStatusUpdated>(_onOrderStatusUpdated);
    _hydrateFromStorage();
  }

  Future<void> _hydrateFromStorage() async {
    final storedOrders = await HiveStorageService.loadOrders();
    if (storedOrders.isNotEmpty) {
      emit(state.copyWith(orders: storedOrders, activeOrder: storedOrders.first));
    }
  }

  Future<void> _onOrderPlaced(OrderPlaced event, Emitter<OrderState> emit) async {
    final updatedList = [event.order, ...state.orders];
    emit(state.copyWith(
      orders: updatedList,
      activeOrder: event.order,
    ));
    await HiveStorageService.saveOrders(updatedList);
  }

  Future<void> _onOrderStatusUpdated(
      OrderStatusUpdated event, Emitter<OrderState> emit) async {
    final updatedOrders = state.orders.map((order) {
      if (order.id == event.orderId) {
        return order.copyWith(status: event.newStatus);
      }
      return order;
    }).toList();

    FoodOrder? newActive = state.activeOrder;
    if (newActive != null && newActive.id == event.orderId) {
      newActive = newActive.copyWith(status: event.newStatus);
    }

    emit(state.copyWith(
      orders: updatedOrders,
      activeOrder: newActive,
    ));
    await HiveStorageService.saveOrders(updatedOrders);
  }
}
