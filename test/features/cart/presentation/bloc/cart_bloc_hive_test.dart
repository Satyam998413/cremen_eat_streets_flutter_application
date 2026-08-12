import 'package:flutter_test/flutter_test.dart';
import 'package:cremen_eatstreet_shop_application/core/services/hive_storage_service.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/domain/entities/cart_item.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/entities/product.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await HiveStorageService.init();
    await HiveStorageService.clearAll();
  });

  tearDown(() async {
    await HiveStorageService.clearAll();
  });

  test('loads persisted cart items when a bloc is created', () async {
    final product = Product(
      id: 'p1',
      name: 'Demo Snack',
      description: 'A tasty demo snack',
      price: 50,
      imageUrl: 'assets/images/cremen_logo.jpg',
      category: 'bhel',
      isSpicy: true,
      isMorningSpecial: false,
    );

    final item = CartItem(
      id: 'item-1',
      product: product,
      quantity: 2,
      spiceLevel: 'Medium',
      hasExtraCheese: true,
      specialInstructions: 'No onion',
    );

    await HiveStorageService.saveCartItems([item]);

    final bloc = CartBloc();
    await Future<void>.delayed(Duration.zero);

    expect(bloc.state.items, hasLength(1));
    expect(bloc.state.items.first.product.name, 'Demo Snack');

    await bloc.close();
  });
}
