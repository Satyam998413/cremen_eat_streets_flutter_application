import 'package:equatable/equatable.dart';
import '../../../cart/domain/entities/cart_item.dart';

/// Matches Postgres `order_status` exactly (see
/// plans/platform-overview.md, cremen_eat_streets, Step 4e) — no separate
/// mobile-only status vocabulary, so an admin-side status change shows up
/// identically here with no translation step to keep in sync.
enum OrderStatus { pendingPayment, confirmed, processing, dispatched, delivered, cancelled }

enum OrderType { pickup, delivery }

class FoodOrder extends Equatable {
  final String id;
  final String? orderNumber;
  final String? publicToken;
  final List<CartItem> items;
  final double subtotal;
  final double shippingFee;
  final double totalAmount;
  final OrderStatus status;
  final OrderType orderType;
  final DateTime createdAt;
  final String customerName;
  final String customerPhone;
  final String? customerEmail;
  final Map<String, dynamic>? shippingAddress;

  /// Free-text note for the whole order — matches `orders.notes`. There is
  /// no per-line-item instructions column in the real schema.
  final String? notes;

  const FoodOrder({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.shippingFee,
    required this.totalAmount,
    required this.status,
    required this.orderType,
    required this.createdAt,
    required this.customerName,
    required this.customerPhone,
    this.orderNumber,
    this.publicToken,
    this.customerEmail,
    this.shippingAddress,
    this.notes,
  });

  FoodOrder copyWith({
    String? id,
    String? orderNumber,
    String? publicToken,
    List<CartItem>? items,
    double? subtotal,
    double? shippingFee,
    double? totalAmount,
    OrderStatus? status,
    OrderType? orderType,
    DateTime? createdAt,
    String? customerName,
    String? customerPhone,
    String? customerEmail,
    Map<String, dynamic>? shippingAddress,
    String? notes,
  }) {
    return FoodOrder(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      publicToken: publicToken ?? this.publicToken,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      shippingFee: shippingFee ?? this.shippingFee,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      orderType: orderType ?? this.orderType,
      createdAt: createdAt ?? this.createdAt,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerEmail: customerEmail ?? this.customerEmail,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'publicToken': publicToken,
      'items': items.map((item) => item.toMap()).toList(),
      'subtotal': subtotal,
      'shippingFee': shippingFee,
      'totalAmount': totalAmount,
      'status': status.name,
      'orderType': orderType.name,
      'createdAt': createdAt.toIso8601String(),
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerEmail': customerEmail,
      'shippingAddress': shippingAddress,
      'notes': notes,
    };
  }

  factory FoodOrder.fromMap(Map<String, dynamic> map) {
    return FoodOrder(
      id: map['id'] as String,
      orderNumber: map['orderNumber'] as String?,
      publicToken: map['publicToken'] as String?,
      items: (map['items'] as List)
          .map((item) => CartItem.fromMap(Map<String, dynamic>.from(item as Map)))
          .toList(),
      subtotal: (map['subtotal'] as num?)?.toDouble() ?? 0,
      shippingFee: (map['shippingFee'] as num?)?.toDouble() ?? 0,
      totalAmount: (map['totalAmount'] as num).toDouble(),
      status: OrderStatus.values.firstWhere(
        (value) => value.name == map['status'],
        orElse: () => OrderStatus.pendingPayment,
      ),
      orderType: OrderType.values.firstWhere(
        (value) => value.name == map['orderType'],
        orElse: () => OrderType.delivery,
      ),
      createdAt: DateTime.parse(map['createdAt'] as String),
      customerName: map['customerName'] as String,
      customerPhone: map['customerPhone'] as String,
      customerEmail: map['customerEmail'] as String?,
      shippingAddress: (map['shippingAddress'] as Map?)?.cast<String, dynamic>(),
      notes: map['notes'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        publicToken,
        items,
        subtotal,
        shippingFee,
        totalAmount,
        status,
        orderType,
        createdAt,
        customerName,
        customerPhone,
        customerEmail,
        shippingAddress,
        notes,
      ];
}
