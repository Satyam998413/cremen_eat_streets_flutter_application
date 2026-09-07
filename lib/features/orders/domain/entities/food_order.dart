import 'package:equatable/equatable.dart';
import 'order_line_item.dart';

/// Matches Postgres `order_status` exactly (see
/// plans/platform-overview.md, cremen_eat_streets, Step 4e) — no separate
/// mobile-only status vocabulary, so an admin-side status change shows up
/// identically here with no translation step to keep in sync.
enum OrderStatus { pendingPayment, confirmed, processing, dispatched, delivered, cancelled }

enum OrderType { pickup, delivery }

/// Postgres uses snake_case enum values ('pending_payment'); this app's
/// Dart enum uses camelCase names — these two functions are the one place
/// that mapping happens.
OrderStatus orderStatusFromDb(String value) {
  return switch (value) {
    'pending_payment' => OrderStatus.pendingPayment,
    'confirmed' => OrderStatus.confirmed,
    'processing' => OrderStatus.processing,
    'dispatched' => OrderStatus.dispatched,
    'delivered' => OrderStatus.delivered,
    'cancelled' => OrderStatus.cancelled,
    _ => OrderStatus.pendingPayment,
  };
}

class FoodOrder extends Equatable {
  final String id;
  final String? orderNumber;
  final String? publicToken;
  final List<OrderLineItem> items;
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
