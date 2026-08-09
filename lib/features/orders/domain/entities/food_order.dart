import 'package:equatable/equatable.dart';
import '../../../cart/domain/entities/cart_item.dart';

enum OrderStatus { received, preparing, ready, outForDelivery, completed }

enum OrderType { pickup, delivery }

class FoodOrder extends Equatable {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final OrderStatus status;
  final OrderType orderType;
  final DateTime createdAt;
  final String customerName;
  final String customerPhone;
  final String? deliveryAddress;

  const FoodOrder({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.orderType,
    required this.createdAt,
    required this.customerName,
    required this.customerPhone,
    this.deliveryAddress,
  });

  FoodOrder copyWith({
    String? id,
    List<CartItem>? items,
    double? totalAmount,
    OrderStatus? status,
    OrderType? orderType,
    DateTime? createdAt,
    String? customerName,
    String? customerPhone,
    String? deliveryAddress,
  }) {
    return FoodOrder(
      id: id ?? this.id,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      orderType: orderType ?? this.orderType,
      createdAt: createdAt ?? this.createdAt,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
    );
  }

  @override
  List<Object?> get props => [
        id,
        items,
        totalAmount,
        status,
        orderType,
        createdAt,
        customerName,
        customerPhone,
        deliveryAddress,
      ];
}
