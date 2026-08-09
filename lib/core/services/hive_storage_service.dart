import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/cart/domain/entities/cart_item.dart';
import '../../features/orders/domain/entities/food_order.dart';

class HiveStorageService {
  static const String _cartBoxName = 'cart_box';
  static const String _ordersBoxName = 'orders_box';

  static Future<void> init() async {
    Directory? dir;
    try {
      dir = await getApplicationDocumentsDirectory();
    } catch (_) {
      dir = Directory.current;
    }

    Hive.init(dir!.path);
    await Hive.openBox<Map<String, dynamic>>(_cartBoxName);
    await Hive.openBox<Map<String, dynamic>>(_ordersBoxName);
  }

  static Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(_cartBoxName);
    await Hive.deleteBoxFromDisk(_ordersBoxName);
  }

  static Future<void> saveCartItems(List<CartItem> items) async {
    await Hive.openBox<Map<String, dynamic>>(_cartBoxName);
    final box = Hive.box<Map<String, dynamic>>(_cartBoxName);
    await box.put('items', {
      'items': items.map((item) => item.toMap()).toList(),
    });
  }

  static Future<List<CartItem>> loadCartItems() async {
    await Hive.openBox<Map<String, dynamic>>(_cartBoxName);
    final box = Hive.box<Map<String, dynamic>>(_cartBoxName);
    final data = box.get('items');
    if (data == null) {
      return const [];
    }

    final rawItems = data['items'] as List<dynamic>? ?? const [];
    return rawItems
        .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  static Future<void> saveOrders(List<FoodOrder> orders) async {
    await Hive.openBox<Map<String, dynamic>>(_ordersBoxName);
    final box = Hive.box<Map<String, dynamic>>(_ordersBoxName);
    await box.put('orders', {
      'orders': orders.map((order) => order.toMap()).toList(),
    });
  }

  static Future<List<FoodOrder>> loadOrders() async {
    await Hive.openBox<Map<String, dynamic>>(_ordersBoxName);
    final box = Hive.box<Map<String, dynamic>>(_ordersBoxName);
    final data = box.get('orders');
    if (data == null) {
      return const [];
    }

    final rawOrders = data['orders'] as List<dynamic>? ?? const [];
    return rawOrders
        .map((order) => FoodOrder.fromMap(order as Map<String, dynamic>))
        .toList();
  }
}
