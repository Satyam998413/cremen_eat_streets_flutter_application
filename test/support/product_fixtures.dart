import 'package:cremen_eatstreet_shop_application/core/error/result.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/entities/product.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/entities/review.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/repositories/reviews_repository.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/get_catalog_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/get_eligible_review_order_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/get_reviews_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/submit_review_usecase.dart';

/// A minimal, valid Product for tests that don't care about every field.
Product buildTestProduct({
  String id = 'p1',
  String name = 'Demo Snack',
  double basePrice = 50,
  bool isSpicy = true,
  bool? isVeg,
  List<ProductVariant> variants = const [],
}) {
  return Product(
    id: id,
    productType: 'packaged',
    slug: id,
    name: name,
    description: 'A tasty demo item',
    basePrice: basePrice,
    isSpicy: isSpicy,
    isVeg: isVeg,
    variants: variants,
    media: const [ProductMedia(url: 'assets/images/cremen_logo.jpg', isPrimary: true)],
  );
}

class _EmptyCatalogRepository implements CatalogRepository {
  @override
  Future<Result<List<Product>>> getCatalog() async => const Success([]);
}

/// For widget smoke tests that need a CatalogBloc in context but don't
/// exercise catalog behavior themselves — never hits the network.
GetCatalogUseCase buildTestGetCatalogUseCase() => GetCatalogUseCase(_EmptyCatalogRepository());

class _EmptyReviewsRepository implements ReviewsRepository {
  @override
  Future<Result<List<Review>>> getReviews(String productId) async => const Success([]);

  @override
  Future<Result<String?>> getEligibleOrderId(String productId) async => const Success(null);

  @override
  Future<Result<void>> submitReview({
    required String productId,
    required String orderId,
    required String reviewerName,
    required int rating,
    String? comment,
  }) async =>
      const Success(null);
}

/// For widget smoke tests that need a ReviewsBloc in context (constructed by
/// ProductDetailScreen itself) but don't exercise review behavior — never
/// hits the network.
({
  GetReviewsUseCase getReviews,
  GetEligibleReviewOrderUseCase getEligibleReviewOrder,
  SubmitReviewUseCase submitReview,
}) buildTestReviewsUseCases() {
  final repository = _EmptyReviewsRepository();
  return (
    getReviews: GetReviewsUseCase(repository),
    getEligibleReviewOrder: GetEligibleReviewOrderUseCase(repository),
    submitReview: SubmitReviewUseCase(repository),
  );
}
