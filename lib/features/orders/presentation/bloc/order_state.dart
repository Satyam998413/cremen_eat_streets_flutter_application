import 'package:equatable/equatable.dart';
import '../../domain/entities/food_order.dart';

class OrderState extends Equatable {
  final List<FoodOrder> orders;
  final FoodOrder? activeOrder;

  const OrderState({
    this.orders = const [],
    this.activeOrder,
  });

  OrderState copyWith({
    List<FoodOrder>? orders,
    FoodOrder? activeOrder,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      activeOrder: activeOrder ?? this.activeOrder,
    );
  }

  @override
  List<Object?> get props => [orders, activeOrder];
}
