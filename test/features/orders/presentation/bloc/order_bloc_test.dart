import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cremen_eatstreet_shop_application/core/error/failure.dart';
import 'package:cremen_eatstreet_shop_application/core/error/result.dart';
import 'package:cremen_eatstreet_shop_application/core/usecases/use_case.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/domain/entities/food_order.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/domain/repositories/order_repository.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/domain/usecases/get_order_by_public_token_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/domain/usecases/get_order_history_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/presentation/bloc/order_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/presentation/bloc/order_event.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/presentation/bloc/order_state.dart';

class _MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late _MockOrderRepository repository;
  late GetOrderHistoryUseCase getOrderHistory;
  late GetOrderByPublicTokenUseCase getOrderByPublicToken;

  setUpAll(() => registerFallbackValue(const NoParams()));

  setUp(() {
    repository = _MockOrderRepository();
    getOrderHistory = GetOrderHistoryUseCase(repository);
    getOrderByPublicToken = GetOrderByPublicTokenUseCase(repository);
  });

  OrderBloc buildBloc() =>
      OrderBloc(getOrderHistory: getOrderHistory, getOrderByPublicToken: getOrderByPublicToken);

  final order = FoodOrder(
    id: 'order-1',
    publicToken: 'token-1',
    items: const [],
    subtotal: 50,
    shippingFee: 0,
    totalAmount: 50,
    status: OrderStatus.confirmed,
    orderType: OrderType.pickup,
    createdAt: DateTime(2026, 1, 1),
    customerName: 'Test User',
    customerPhone: '9999999999',
  );

  blocTest<OrderBloc, OrderState>(
    'emits [loading, historyLoaded] for a logged-in customer',
    setUp: () => when(() => repository.getHistory()).thenAnswer((_) async => Success([order])),
    build: buildBloc,
    act: (bloc) => bloc.add(const OrderEvent.historyRequested()),
    expect: () => [
      const OrderState.loading(),
      OrderState.historyLoaded([order]),
    ],
  );

  blocTest<OrderBloc, OrderState>(
    'emits [loading, historyLoaded([])] for a guest — RLS returns nothing, not an error',
    setUp: () => when(() => repository.getHistory()).thenAnswer((_) async => const Success([])),
    build: buildBloc,
    act: (bloc) => bloc.add(const OrderEvent.historyRequested()),
    expect: () => [
      const OrderState.loading(),
      const OrderState.historyLoaded([]),
    ],
  );

  blocTest<OrderBloc, OrderState>(
    'emits [loading, detailLoaded] when a public_token resolves',
    setUp: () => when(() => repository.getByPublicToken('token-1')).thenAnswer((_) async => Success(order)),
    build: buildBloc,
    act: (bloc) => bloc.add(const OrderEvent.detailRequested('token-1')),
    expect: () => [
      const OrderState.loading(),
      OrderState.detailLoaded(order),
    ],
  );

  blocTest<OrderBloc, OrderState>(
    'emits [loading, failure] for an unknown public_token',
    setUp: () => when(() => repository.getByPublicToken('bad-token'))
        .thenAnswer((_) async => const Failed(ValidationFailure('Order not found.'))),
    build: buildBloc,
    act: (bloc) => bloc.add(const OrderEvent.detailRequested('bad-token')),
    expect: () => [
      const OrderState.loading(),
      const OrderState.failure('Order not found.'),
    ],
  );
}
