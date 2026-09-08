import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/food_order.dart';
import '../repositories/order_repository.dart';

@lazySingleton
class GetOrderByPublicTokenUseCase implements UseCase<FoodOrder, String> {
  const GetOrderByPublicTokenUseCase(this._repository);

  final OrderRepository _repository;

  @override
  Future<Result<FoodOrder>> call(String publicToken) {
    return _repository.getByPublicToken(publicToken);
  }
}
