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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'status': status.name,
      'orderType': orderType.name,
      'createdAt': createdAt.toIso8601String(),
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deliveryAddress': deliveryAddress,
    };
  }

  factory FoodOrder.fromMap(Map<String, dynamic> map) {
    return FoodOrder(
      id: map['id'] as String,
      items: (map['items'] as List)
          .map((item) => CartItem.fromMap(Map<String, dynamic>.from(item as Map)))
          .toList(),
      totalAmount: (map['totalAmount'] as num).toDouble(),
      status: OrderStatus.values.firstWhere(
        (value) => value.name == map['status'],
        orElse: () => OrderStatus.received,
      ),
      orderType: OrderType.values.firstWhere(
        (value) => value.name == map['orderType'],
        orElse: () => OrderType.delivery,
      ),
      createdAt: DateTime.parse(map['createdAt'] as String),
      customerName: map['customerName'] as String,
      customerPhone: map['customerPhone'] as String,
      deliveryAddress: map['deliveryAddress'] as String?,
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
