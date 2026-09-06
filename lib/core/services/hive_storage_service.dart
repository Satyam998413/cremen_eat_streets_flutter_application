import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/cart/domain/entities/cart_item.dart';
import '../../features/orders/domain/entities/food_order.dart';

class HiveStorageService {
  static const String _cartBoxName = 'cart_box';
  static const String _ordersBoxName = 'orders_box';

  /// [storagePath] lets callers (tests) point Hive at an isolated directory —
  /// without it, every caller that falls into the catch-all below shares the
  /// same on-disk path, and concurrent test files fight over the same lock file.
  static Future<void> init({String? storagePath}) async {
    Directory dir;
    if (storagePath != null) {
      dir = Directory(storagePath);
    } else {
      try {
        dir = await getApplicationDocumentsDirectory();
      } catch (_) {
        dir = Directory.current;
      }
    }

    Hive.init(dir.path);
    // Opened untyped (not Box<Map<String, dynamic>>): Hive's binary reader
    // always deserializes a stored map back as Map<dynamic, dynamic>, so a
    // box typed on Map<String, dynamic> throws a cast error on every read of
    // real persisted data — the manual Map<String, dynamic>.from(...) below
    // is what actually normalizes the shape, and needs an untyped box to run.
    await Hive.openBox(_cartBoxName);
    await Hive.openBox(_ordersBoxName);
  }

  static Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(_cartBoxName);
    await Hive.deleteBoxFromDisk(_ordersBoxName);
  }

  static Future<void> saveCartItems(List<CartItem> items) async {
    await Hive.openBox(_cartBoxName);
    final box = Hive.box(_cartBoxName);
    await box.put('items', {
      'items': items.map((item) => item.toMap()).toList(),
    });
  }

  static Future<List<CartItem>> loadCartItems() async {
    await Hive.openBox(_cartBoxName);
    final box = Hive.box(_cartBoxName);
    final rawData = box.get('items');
    if (rawData == null) {
      return const [];
    }
    final data = Map<String, dynamic>.from(rawData as Map);
    final rawItems = data['items'] as List<dynamic>? ?? const [];
    return rawItems
        .map((item) => CartItem.fromMap(Map<String, dynamic>.from(item as Map)))
        .toList();
  }

  static Future<void> saveOrders(List<FoodOrder> orders) async {
    await Hive.openBox(_ordersBoxName);
    final box = Hive.box(_ordersBoxName);
    await box.put('orders', {
      'orders': orders.map((order) => order.toMap()).toList(),
    });
  }

  static Future<List<FoodOrder>> loadOrders() async {
    await Hive.openBox(_ordersBoxName);
    final box = Hive.box(_ordersBoxName);
    final rawData = box.get('orders');
    if (rawData == null) {
      return const [];
    }
    final data = Map<String, dynamic>.from(rawData as Map);
    final rawOrders = data['orders'] as List<dynamic>? ?? const [];
    return rawOrders
        .map((order) => FoodOrder.fromMap(Map<String, dynamic>.from(order as Map)))
        .toList();
  }
}
