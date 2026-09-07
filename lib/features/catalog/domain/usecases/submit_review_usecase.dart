import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/reviews_repository.dart';

class SubmitReviewParams {
  const SubmitReviewParams({
    required this.productId,
    required this.orderId,
    required this.reviewerName,
    required this.rating,
    this.comment,
  });

  final String productId;
  final String orderId;
  final String reviewerName;
  final int rating;
  final String? comment;
}

class SubmitReviewUseCase implements UseCase<void, SubmitReviewParams> {
  const SubmitReviewUseCase(this._repository);

  final ReviewsRepository _repository;

  @override
  Future<Result<void>> call(SubmitReviewParams params) {
    return _repository.submitReview(
      productId: params.productId,
      orderId: params.orderId,
      reviewerName: params.reviewerName,
      rating: params.rating,
      comment: params.comment,
    );
  }
}
