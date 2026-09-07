import 'package:supabase_flutter/supabase_flutter.dart' show PostgrestException;
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/catalog_remote_datasource.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl(this._remote);

  final CatalogRemoteDataSource _remote;

  @override
  Future<Result<List<Product>>> getCatalog() async {
    try {
      final rows = await _remote.fetchActiveProducts();
      return Success(rows.map(_toProduct).toList());
    } on PostgrestException catch (e) {
      return Failed(NetworkFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<Product>> getProductBySlug(String slug) async {
    try {
      final row = await _remote.fetchProductBySlug(slug);
      if (row == null) return const Failed(ValidationFailure('Product not found.'));
      return Success(_toProduct(row));
    } on PostgrestException catch (e) {
      return Failed(NetworkFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  Product _toProduct(Map<String, dynamic> row) {
    final mediaRows = row['product_media'] as List<dynamic>? ?? const [];
    final media = mediaRows.map((raw) {
      final m = raw as Map<String, dynamic>;
      return ProductMedia(
        url: _remote.publicMediaUrl(m['storage_path'] as String),
        isPrimary: m['is_primary'] as bool? ?? false,
        altText: m['alt_text'] as String?,
      );
    }).toList();

    final variantRows = row['variants'] as List<dynamic>? ?? const [];
    final variants = variantRows.map((raw) {
      final v = raw as Map<String, dynamic>;
      return ProductVariant(label: v['label'] as String, price: (v['price'] as num).toDouble());
    }).toList();

    return Product(
      id: row['id'] as String,
      productType: row['product_type'] as String,
      slug: row['slug'] as String,
      name: row['name'] as String,
      subtitle: row['subtitle'] as String?,
      description: row['description'] as String? ?? '',
      basePrice: (row['base_price'] as num).toDouble(),
      compareAtPrice: (row['compare_at_price'] as num?)?.toDouble(),
      variants: variants,
      requiresShipping: row['requires_shipping'] as bool? ?? true,
      isVeg: row['is_veg'] as bool?,
      isSpicy: row['is_spicy'] as bool?,
      prepTimeLabel: row['prep_time_label'] as String?,
      ratingAvg: (row['rating_avg'] as num?)?.toDouble() ?? 0,
      ratingCount: row['rating_count'] as int? ?? 0,
      media: media,
    );
  }
}
