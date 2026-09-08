import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/food_order.dart';
import '../repositories/order_repository.dart';

@lazySingleton
class GetOrderHistoryUseCase implements UseCase<List<FoodOrder>, NoParams> {
  const GetOrderHistoryUseCase(this._repository);

  final OrderRepository _repository;

  @override
  Future<Result<List<FoodOrder>>> call(NoParams params) {
    return _repository.getHistory();
  }
}
