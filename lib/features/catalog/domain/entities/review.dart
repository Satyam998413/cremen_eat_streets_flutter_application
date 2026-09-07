import 'package:equatable/equatable.dart';

/// Mirrors `product_reviews` (see plans/platform-overview.md,
/// cremen_eat_streets, Step 4a).
class Review extends Equatable {
  const Review({
    required this.id,
    required this.reviewerName,
    required this.rating,
    required this.createdAt,
    this.comment,
  });

  final String id;
  final String reviewerName;
  final int rating; // 1-5
  final String? comment;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, reviewerName, rating, comment, createdAt];
}
