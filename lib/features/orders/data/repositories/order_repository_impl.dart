import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show PostgrestException;
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/food_order.dart';
import '../../domain/entities/order_line_item.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl(this._remote);

  final OrderRemoteDataSource _remote;

  @override
  Future<Result<List<FoodOrder>>> getHistory() async {
    try {
      final rows = await _remote.fetchHistory();
      return Success(rows.map(_toFoodOrder).toList());
    } on PostgrestException catch (e) {
      return Failed(NetworkFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<FoodOrder>> getByPublicToken(String publicToken) async {
    try {
      final row = await _remote.fetchByPublicToken(publicToken);
      if (row == null) return const Failed(ValidationFailure('Order not found.'));
      return Success(_toFoodOrder(row));
    } on PostgrestException catch (e) {
      return Failed(NetworkFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  FoodOrder _toFoodOrder(Map<String, dynamic> row) {
    final itemRows = row['order_items'] as List<dynamic>? ?? const [];
    final items = itemRows.map((raw) {
      final item = (raw is Map) ? Map<String, dynamic>.from(raw) : const <String, dynamic>{};
      return OrderLineItem(
        productId: item['product_id'] as String?,
        productName: (item['product_name'] as String?) ?? 'Unknown Item',
        variantLabel: item['variant_label'] as String?,
        unitPrice: (item['unit_price'] as num?)?.toDouble() ?? 0.0,
        quantity: (item['quantity'] as num?)?.toInt() ?? 1,
        lineTotal: (item['line_total'] as num?)?.toDouble() ?? 0.0,
      );
    }).toList();

    final fulfillmentType = row['fulfillment_type'] as String? ?? 'pickup';
    final rawCreatedAt = row['created_at']?.toString();
    final createdAt = rawCreatedAt != null ? DateTime.tryParse(rawCreatedAt) ?? DateTime.now() : DateTime.now();

    return FoodOrder(
      id: (row['id'] as String?) ?? '',
      orderNumber: row['order_number'] as String?,
      publicToken: row['public_token'] as String?,
      items: items,
      subtotal: (row['subtotal'] as num?)?.toDouble() ?? 0.0,
      shippingFee: (row['shipping_fee'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (row['total'] as num?)?.toDouble() ?? 0.0,
      status: orderStatusFromDb((row['status'] as String?) ?? 'pending_payment'),
      orderType: fulfillmentType == 'pickup' ? OrderType.pickup : OrderType.delivery,
      createdAt: createdAt,
      customerName: (row['customer_name'] as String?) ?? 'Customer',
      customerPhone: (row['customer_phone'] as String?) ?? '',
      customerEmail: row['customer_email'] as String?,
      shippingAddress: (row['shipping_address'] is Map)
          ? Map<String, dynamic>.from(row['shipping_address'] as Map)
          : null,
      notes: row['notes'] as String?,
    );
  }
}
