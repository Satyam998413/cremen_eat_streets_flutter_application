import 'package:supabase_flutter/supabase_flutter.dart';

/// Thin wrapper around the Supabase calls this feature needs. Throws
/// PostgrestException — mapping it to a typed Failure is the repository's job.
class CatalogRemoteDataSource {
  CatalogRemoteDataSource(this._client);

  final SupabaseClient _client;

  /// Active products with their media, via Postgrest's FK-based embed
  /// (product_media.product_id -> products.id) — one round trip, same rows
  /// the website's public catalog reads.
  Future<List<Map<String, dynamic>>> fetchActiveProducts() async {
    final rows = await _client
        .from('products')
        .select(
          'id, product_type, slug, name, subtitle, description, base_price, compare_at_price, '
          'variants, requires_shipping, is_veg, is_spicy, prep_time_label, rating_avg, rating_count, '
          'product_media(storage_path, is_primary, alt_text)',
        )
        .eq('status', 'active')
        .order('sort_order');
    return List<Map<String, dynamic>>.from(rows as List);
  }

  /// Resolves a storage_path into a fetchable URL — synchronous string
  /// construction against the public `cremen_media` bucket, no network call.
  String publicMediaUrl(String storagePath) {
    return _client.storage.from('cremen_media').getPublicUrl(storagePath);
  }
}
