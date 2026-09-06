import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';

part 'catalog_state.freezed.dart';

@freezed
sealed class CatalogState with _$CatalogState {
  const factory CatalogState.loading() = CatalogLoading;
  const factory CatalogState.loaded({
    required List<Product> products,
    @Default(null) String? selectedProductType,
    @Default('') String searchQuery,
    @Default(false) bool isRefreshing,
  }) = CatalogLoaded;
  const factory CatalogState.failure(String message) = CatalogFailure;
}

extension CatalogLoadedX on CatalogLoaded {
  List<Product> get filteredProducts {
    return products.where((product) {
      final matchesType = selectedProductType == null || product.productType == selectedProductType;
      final query = searchQuery.trim().toLowerCase();
      final matchesQuery = query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query);
      return matchesType && matchesQuery;
    }).toList();
  }
}
