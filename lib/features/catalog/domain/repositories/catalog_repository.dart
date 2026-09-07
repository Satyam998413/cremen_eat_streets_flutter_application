import '../../../../core/error/result.dart';
import '../entities/product.dart';

abstract class CatalogRepository {
  /// Every active product, from the same `products`/`product_media` tables
  /// the website reads (see plans/platform-overview.md Step 4c: public read
  /// RLS on status='active').
  Future<Result<List<Product>>> getCatalog();

  /// Looks up one active product by slug — for `/shop/:slug` deep links
  /// arriving before (or without) an in-memory catalog to search instead.
  Future<Result<Product>> getProductBySlug(String slug);
}
