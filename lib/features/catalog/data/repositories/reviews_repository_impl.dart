import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException, PostgrestException;

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/reviews_repository.dart';
import '../datasources/reviews_remote_datasource.dart';

@LazySingleton(as: ReviewsRepository)
class ReviewsRepositoryImpl implements ReviewsRepository {
  ReviewsRepositoryImpl(this._remote);

  final ReviewsRemoteDataSource _remote;

  @override
  Future<Result<List<Review>>> getReviews(String productId) async {
    try {
      final rows = await _remote.fetchReviews(productId);
      final reviews = rows.map((row) {
        return Review(
          id: row['id'] as String,
          reviewerName: row['reviewer_name'] as String,
          rating: row['rating'] as int,
          createdAt: DateTime.parse(row['created_at'] as String),
          comment: row['comment'] as String?,
        );
      }).toList();
      return Success(reviews);
    } on PostgrestException catch (e) {
      return Failed(NetworkFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<String?>> getEligibleOrderId(String productId) async {
    try {
      final orderId = await _remote.fetchEligibleOrderId(productId);
      return Success(orderId);
    } on PostgrestException catch (e) {
      return Failed(NetworkFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> submitReview({
    required String productId,
    required String orderId,
    required String reviewerName,
    required int rating,
    String? comment,
  }) async {
    try {
      await _remote.insertReview(
        productId: productId,
        orderId: orderId,
        reviewerName: reviewerName,
        rating: rating,
        comment: comment,
      );
      return const Success(null);
    } on AuthException catch (e) {
      return Failed(AuthFailure(e.message));
    } on PostgrestException catch (e) {
      return Failed(NetworkFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }
}
