import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/product_data.dart';
import 'catalog_event.dart';
import 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogInitial()) {
    on<CatalogStarted>(_onCatalogStarted);
    on<CatalogCategorySelected>(_onCatalogCategorySelected);
    on<CatalogSearchQueryChanged>(_onCatalogSearchQueryChanged);
  }

  void _onCatalogStarted(CatalogStarted event, Emitter<CatalogState> emit) {
    emit(CatalogLoading());
    // Simulate data fetch
    emit(const CatalogLoaded(products: ProductData.sampleProducts));
  }

  void _onCatalogCategorySelected(
      CatalogCategorySelected event, Emitter<CatalogState> emit) {
    if (state is CatalogLoaded) {
      final current = state as CatalogLoaded;
      emit(CatalogLoaded(
        products: current.products,
        selectedCategory: event.category,
        searchQuery: current.searchQuery,
      ));
    }
  }

  void _onCatalogSearchQueryChanged(
      CatalogSearchQueryChanged event, Emitter<CatalogState> emit) {
    if (state is CatalogLoaded) {
      final current = state as CatalogLoaded;
      emit(CatalogLoaded(
        products: current.products,
        selectedCategory: current.selectedCategory,
        searchQuery: event.query,
      ));
    }
  }
}
