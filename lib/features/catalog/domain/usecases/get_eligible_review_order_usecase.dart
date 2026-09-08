import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/reviews_repository.dart';

@lazySingleton
class GetEligibleReviewOrderUseCase implements UseCase<String?, String> {
  const GetEligibleReviewOrderUseCase(this._repository);

  final ReviewsRepository _repository;

  @override
  Future<Result<String?>> call(String productId) {
    return _repository.getEligibleOrderId(productId);
  }
}
