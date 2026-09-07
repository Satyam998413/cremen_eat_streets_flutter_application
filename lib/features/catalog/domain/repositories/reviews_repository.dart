import '../../../../core/error/result.dart';
import '../entities/review.dart';

abstract class ReviewsRepository {
  /// Public read — no auth needed (see platform-overview.md Step 4c:
  /// "product_reviews | public read").
  Future<Result<List<Review>>> getReviews(String productId);

  /// Returns the id of a delivered order (owned by the caller) containing
  /// this product, if one exists — the review form is only shown when this
  /// is non-null, matching the RLS insert policy's own requirement
  /// ("exists(delivered order containing this product, owned by caller)").
  /// `null` for a guest (no session) or a customer who never bought this
  /// product in a delivered order.
  Future<Result<String?>> getEligibleOrderId(String productId);

  Future<Result<void>> submitReview({
    required String productId,
    required String orderId,
    required String reviewerName,
    required int rating,
    String? comment,
  });
}
