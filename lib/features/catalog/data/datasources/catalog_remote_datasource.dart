import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Thin wrapper around the Supabase calls this feature needs. Throws
/// PostgrestException — mapping it to a typed Failure is the repository's job.
@lazySingleton
class CatalogRemoteDataSource {
  CatalogRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const _productColumns =
      'id, product_type, slug, name, subtitle, description, base_price, compare_at_price, '
      'wholesale_price, variants, requires_shipping, is_veg, is_spicy, prep_time_label, rating_avg, '
      'rating_count, marketplace_links, product_media(storage_path, is_primary, alt_text)';

  /// Active products with their media, via Postgrest's FK-based embed
  /// (product_media.product_id -> products.id) — one round trip, same rows
  /// the website's public catalog reads.
  Future<List<Map<String, dynamic>>> fetchActiveProducts() async {
    final rows = await _client.from('products').select(_productColumns).eq('status', 'active').order('sort_order');
    return List<Map<String, dynamic>>.from(rows as List);
  }

  /// Looks up a single product by its public `slug` — used to resolve
  /// `/shop/:slug` deep links (the website's own product-detail URL shape)
  /// when the app has no in-memory catalog to look the product up from yet.
  Future<Map<String, dynamic>?> fetchProductBySlug(String slug) {
    return _client.from('products').select(_productColumns).eq('slug', slug).eq('status', 'active').maybeSingle();
  }

  /// Shared logo per marketplace platform name (cremen_eat_streets,
  /// public.marketplace_logos, migration 021) — one small table, not
  /// per-product, so a logo uploaded once from the admin panel (or from any
  /// product) shows up for every product whose marketplace_links mentions
  /// that same platform name.
  Future<List<Map<String, dynamic>>> fetchMarketplaceLogos() async {
    final rows = await _client.from('marketplace_logos').select('platform_key, logo_path');
    return List<Map<String, dynamic>>.from(rows as List);
  }

  /// Resolves a storage_path into a fetchable URL — synchronous string
  /// construction against the public `cremen_media` bucket, no network call.
  String publicMediaUrl(String storagePath) {
    return _client.storage.from('cremen_media').getPublicUrl(storagePath);
  }
}
