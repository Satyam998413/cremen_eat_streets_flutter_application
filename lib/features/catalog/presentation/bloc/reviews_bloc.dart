import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../domain/usecases/get_eligible_review_order_usecase.dart';
import '../../domain/usecases/get_reviews_usecase.dart';
import '../../domain/usecases/submit_review_usecase.dart';
import 'reviews_event.dart';
import 'reviews_state.dart';

/// `@injectable` (not a singleton) — every `ProductDetailScreen` needs its
/// own fresh instance scoped to one product, never a shared/reused bloc.
@injectable
class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  ReviewsBloc({
    required this._getReviews,
    required GetEligibleReviewOrderUseCase getEligibleReviewOrder,
    required this._submitReview,
  })  : _getEligibleReviewOrder = getEligibleReviewOrder,
        super(const ReviewsState.loading()) {
    on<ReviewsLoadRequested>(_onLoadRequested);
    on<ReviewsSubmitRequested>(_onSubmitRequested);
  }

  final GetReviewsUseCase _getReviews;
  final GetEligibleReviewOrderUseCase _getEligibleReviewOrder;
  final SubmitReviewUseCase _submitReview;

  String? _productId;

  Future<void> _onLoadRequested(ReviewsLoadRequested event, Emitter<ReviewsState> emit) async {
    _productId = event.productId;
    emit(const ReviewsState.loading());

    final reviewsResult = await _getReviews(event.productId);
    final eligibleResult = await _getEligibleReviewOrder(event.productId);

    switch (reviewsResult) {
      case Success(:final value):
        final eligibleOrderId = switch (eligibleResult) {
          Success(:final value) => value,
          Failed() => null,
        };
        emit(ReviewsState.loaded(reviews: value, eligibleOrderId: eligibleOrderId));
      case Failed(:final failure):
        emit(ReviewsState.failure(failure.message));
    }
  }

  Future<void> _onSubmitRequested(ReviewsSubmitRequested event, Emitter<ReviewsState> emit) async {
    final current = state;
    if (current is! ReviewsLoaded || current.eligibleOrderId == null || _productId == null) {
      return;
    }

    emit(current.copyWith(isSubmitting: true, submitError: null));

    final result = await _submitReview(SubmitReviewParams(
      productId: _productId!,
      orderId: current.eligibleOrderId!,
      reviewerName: event.reviewerName,
      rating: event.rating,
      comment: event.comment,
    ));

    switch (result) {
      case Success():
        add(ReviewsEvent.loadRequested(_productId!));
        emit((state as ReviewsLoaded).copyWith(isSubmitting: false, submitSucceeded: true));
      case Failed(:final failure):
        emit(current.copyWith(isSubmitting: false, submitError: failure.message));
    }
  }
}
