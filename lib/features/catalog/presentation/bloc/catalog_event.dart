import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_event.freezed.dart';

@freezed
sealed class CatalogEvent with _$CatalogEvent {
  const factory CatalogEvent.requested() = CatalogRequested;
  const factory CatalogEvent.refreshRequested() = CatalogRefreshRequested;
  const factory CatalogEvent.categorySelected(String? productType) = CatalogCategorySelected;
  const factory CatalogEvent.searchQueryChanged(String query) = CatalogSearchQueryChanged;
}
