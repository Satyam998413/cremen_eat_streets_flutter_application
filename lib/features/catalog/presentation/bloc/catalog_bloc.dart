import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../../domain/usecases/get_catalog_usecase.dart';
import 'catalog_event.dart';
import 'catalog_state.dart';

@lazySingleton
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc(this._getCatalog) : super(const CatalogState.loading()) {
    on<CatalogRequested>(_onRequested);
    on<CatalogRefreshRequested>(_onRefreshRequested);
    on<CatalogCategorySelected>(_onCategorySelected);
    on<CatalogSearchQueryChanged>(_onSearchQueryChanged);
  }

  final GetCatalogUseCase _getCatalog;

  Future<void> _onRequested(CatalogRequested event, Emitter<CatalogState> emit) async {
    emit(const CatalogState.loading());
    final result = await _getCatalog(const NoParams());
    switch (result) {
      case Success(:final value):
        emit(CatalogState.loaded(products: value));
      case Failed(:final failure):
        emit(CatalogState.failure(failure.message));
    }
  }

  Future<void> _onRefreshRequested(CatalogRefreshRequested event, Emitter<CatalogState> emit) async {
    final current = state;
    if (current is! CatalogLoaded) return add(const CatalogEvent.requested());
    emit(current.copyWith(isRefreshing: true));
    final result = await _getCatalog(const NoParams());
    switch (result) {
      case Success(:final value):
        emit(current.copyWith(products: value, isRefreshing: false));
      case Failed():
        // A failed background refresh keeps showing the list that's already
        // on screen rather than replacing it with an error.
        emit(current.copyWith(isRefreshing: false));
    }
  }

  void _onCategorySelected(CatalogCategorySelected event, Emitter<CatalogState> emit) {
    final current = state;
    if (current is CatalogLoaded) {
      emit(current.copyWith(selectedProductType: event.productType));
    }
  }

  void _onSearchQueryChanged(CatalogSearchQueryChanged event, Emitter<CatalogState> emit) {
    final current = state;
    if (current is CatalogLoaded) {
      emit(current.copyWith(searchQuery: event.query));
    }
  }
}
