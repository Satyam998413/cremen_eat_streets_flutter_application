import 'package:cremen_eatstreet_shop_application/core/error/failure.dart';
import 'package:cremen_eatstreet_shop_application/core/error/result.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/domain/entities/food_order.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/domain/repositories/order_repository.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/domain/usecases/get_order_by_public_token_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/domain/usecases/get_order_history_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/presentation/bloc/order_bloc.dart';

class _EmptyOrderRepository implements OrderRepository {
  @override
  Future<Result<List<FoodOrder>>> getHistory() async => const Success([]);

  @override
  Future<Result<FoodOrder>> getByPublicToken(String publicToken) async =>
      const Failed(ValidationFailure('Order not found.'));
}

/// For widget smoke tests that need an OrderBloc in context but don't
/// exercise order behavior themselves — never hits the network.
OrderBloc buildTestOrderBloc() {
  final repository = _EmptyOrderRepository();
  return OrderBloc(
    getOrderHistory: GetOrderHistoryUseCase(repository),
    getOrderByPublicToken: GetOrderByPublicTokenUseCase(repository),
  );
}
