import 'package:flutter_test/flutter_test.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/domain/entities/cart_item.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/presentation/bloc/cart_event.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/presentation/bloc/cart_state.dart';
import '../../../../support/hive_test_utils.dart';
import '../../../../support/product_fixtures.dart';

void main() {
  group('CartBloc Tests', () {
    late CartBloc cartBloc;

    setUpAll(() async {
      await initIsolatedHive();
    });

    setUp(() {
      // A fresh, isolated temp directory is created once per test file in
      // setUpAll, and neither test below persists anything before this one
      // runs — nothing to wipe between them.
      cartBloc = CartBloc();
    });

    tearDown(() {
      cartBloc.close();
    });

    test('initial state is empty CartState', () {
      expect(cartBloc.state.items, isEmpty);
      expect(cartBloc.state.totalAmount, equals(0.0));
    });

    test('adds item to cart correctly', () async {
      final sampleProduct = buildTestProduct();
      final cartItem = CartItem(
        id: '1',
        product: sampleProduct,
        quantity: 1,
      );

      cartBloc.add(CartItemAdded(cartItem));

      await expectLater(
        cartBloc.stream,
        emits(CartState(items: [cartItem])),
      );
    });
  });
}
