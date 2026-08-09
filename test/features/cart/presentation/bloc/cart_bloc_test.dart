import 'package:flutter_test/flutter_test.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/domain/entities/cart_item.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/presentation/bloc/cart_event.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/presentation/bloc/cart_state.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/data/models/product_data.dart';

void main() {
  group('CartBloc Tests', () {
    late CartBloc cartBloc;

    setUp(() {
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
      final sampleProduct = ProductData.sampleProducts.first;
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
