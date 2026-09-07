import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/review.dart';

part 'reviews_state.freezed.dart';

@freezed
sealed class ReviewsState with _$ReviewsState {
  const factory ReviewsState.loading() = ReviewsLoading;
  const factory ReviewsState.loaded({
    required List<Review> reviews,
    String? eligibleOrderId,
    @Default(false) bool isSubmitting,
    @Default(false) bool submitSucceeded,
    String? submitError,
  }) = ReviewsLoaded;
  const factory ReviewsState.failure(String message) = ReviewsFailure;
}

extension ReviewsLoadedX on ReviewsLoaded {
  bool get canReview => eligibleOrderId != null;
}
