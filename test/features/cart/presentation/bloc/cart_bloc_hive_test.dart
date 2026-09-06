import 'package:flutter_test/flutter_test.dart';
import 'package:cremen_eatstreet_shop_application/core/services/hive_storage_service.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/domain/entities/cart_item.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/presentation/bloc/cart_bloc.dart';
import '../../../../support/hive_test_utils.dart';
import '../../../../support/product_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initIsolatedHive();
    await HiveStorageService.clearAll();
  });

  tearDown(() async {
    await HiveStorageService.clearAll();
  });

  test('loads persisted cart items when a bloc is created', () async {
    final product = buildTestProduct();

    final item = CartItem(
      id: 'item-1',
      product: product,
      quantity: 2,
    );

    await HiveStorageService.saveCartItems([item]);

    final bloc = CartBloc();
    await Future<void>.delayed(Duration.zero);

    expect(bloc.state.items, hasLength(1));
    expect(bloc.state.items.first.product.name, 'Demo Snack');

    await bloc.close();
  });
}
