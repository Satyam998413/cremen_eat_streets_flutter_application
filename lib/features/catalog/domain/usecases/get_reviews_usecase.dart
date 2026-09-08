import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/review.dart';
import '../repositories/reviews_repository.dart';

@lazySingleton
class GetReviewsUseCase implements UseCase<List<Review>, String> {
  const GetReviewsUseCase(this._repository);

  final ReviewsRepository _repository;

  @override
  Future<Result<List<Review>>> call(String productId) {
    return _repository.getReviews(productId);
  }
}
