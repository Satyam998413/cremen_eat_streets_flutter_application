import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/wholesaler_profile.dart';
import '../../domain/usecases/get_assigned_wholesalers_usecase.dart';
import 'sales_wholesaler_state.dart';

/// Holds which wholesaler a salesman is currently "ordering for" — a single
/// app-scoped selection (like [CartBloc]'s single cart) that both the B2B
/// catalog screen and the checkout screen read from, so the choice made on
/// one carries over to the other without any navigation-argument plumbing.
/// Never touched for a customer or wholesaler account (a wholesaler always
/// orders for themselves; wholesalerId is forced-to-self server-side).
@lazySingleton
class SalesWholesalerCubit extends Cubit<SalesWholesalerState> {
  SalesWholesalerCubit(this._getAssignedWholesalers) : super(const SalesWholesalerState());

  final GetAssignedWholesalersUseCase _getAssignedWholesalers;

  Future<void> loadFor(String salesId) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await _getAssignedWholesalers(salesId);
    switch (result) {
      case Success(:final value):
        // Keep an already-selected wholesaler selected across a refresh, as
        // long as it's still in the (active-only) list that came back.
        final stillValid = state.selected != null && value.any((w) => w.id == state.selected!.id);
        emit(state.copyWith(isLoading: false, wholesalers: value, clearSelected: !stillValid));
      case Failed(:final failure):
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
    }
  }

  void select(WholesalerProfile wholesaler) {
    emit(state.copyWith(selected: wholesaler));
  }

  void clearSelection() {
    emit(state.copyWith(clearSelected: true));
  }
}
