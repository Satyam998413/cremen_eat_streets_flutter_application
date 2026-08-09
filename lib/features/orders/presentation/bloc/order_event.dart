import 'package:equatable/equatable.dart';
import '../../domain/entities/food_order.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class OrderPlaced extends OrderEvent {
  final FoodOrder order;
  const OrderPlaced(this.order);

  @override
  List<Object?> get props => [order];
}

class OrderStatusUpdated extends OrderEvent {
  final String orderId;
  final OrderStatus newStatus;

  const OrderStatusUpdated(this.orderId, this.newStatus);

  @override
  List<Object?> get props => [orderId, newStatus];
}
