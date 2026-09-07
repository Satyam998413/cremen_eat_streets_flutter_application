import 'package:freezed_annotation/freezed_annotation.dart';

part 'reviews_event.freezed.dart';

@freezed
sealed class ReviewsEvent with _$ReviewsEvent {
  const factory ReviewsEvent.loadRequested(String productId) = ReviewsLoadRequested;
  const factory ReviewsEvent.submitRequested({
    required String reviewerName,
    required int rating,
    String? comment,
  }) = ReviewsSubmitRequested;
}
