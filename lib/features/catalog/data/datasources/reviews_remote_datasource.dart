import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException, SupabaseClient;

/// Thin wrapper around the Supabase calls this feature needs. Throws
/// PostgrestException — mapping it to a typed Failure is the repository's job.
@lazySingleton
class ReviewsRemoteDataSource {
  ReviewsRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<List<Map<String, dynamic>>> fetchReviews(String productId) async {
    final rows = await _client
        .from('product_reviews')
        .select('id, reviewer_name, rating, comment, created_at')
        .eq('product_id', productId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(rows as List);
  }

  /// `!inner` forces the join so the `orders.status` filter actually
  /// restricts which order_items rows come back (a left embed wouldn't).
  /// RLS ("customer read own") already scopes both tables to the caller.
  Future<String?> fetchEligibleOrderId(String productId) async {
    final rows = await _client
        .from('order_items')
        .select('order_id, orders!inner(status)')
        .eq('product_id', productId)
        .eq('orders.status', 'delivered')
        .limit(1);
    final list = List<Map<String, dynamic>>.from(rows as List);
    if (list.isEmpty) return null;
    return list.first['order_id'] as String;
  }

  /// Upsert, not insert: the unique `(product_id, order_id)` constraint plus
  /// the RLS "customer insert/update own" policy both exist so a customer
  /// can revise their review for the same order — a plain insert would
  /// throw a unique-violation on resubmission. `user_id` must be set
  /// explicitly (not defaulted server-side) because the WITH CHECK clause
  /// is `user_id = auth.uid()`.
  Future<void> insertReview({
    required String productId,
    required String orderId,
    required String reviewerName,
    required int rating,
    String? comment,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw const AuthException('Must be signed in to submit a review.');
    }
    await _client.from('product_reviews').upsert(
      {
        'product_id': productId,
        'order_id': orderId,
        'user_id': userId,
        'reviewer_name': reviewerName,
        'rating': rating,
        'comment': comment,
      },
      onConflict: 'product_id,order_id',
    );
  }
}
