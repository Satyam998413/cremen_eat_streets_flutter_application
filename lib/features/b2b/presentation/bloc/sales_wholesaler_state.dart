import 'package:equatable/equatable.dart';
import '../../domain/entities/wholesaler_profile.dart';

/// State of a salesman's "ordering for" wholesaler picker — who they're
/// placing the current/next order on behalf of, plus their own list of
/// assigned wholesalers to pick from.
class SalesWholesalerState extends Equatable {
  const SalesWholesalerState({
    this.isLoading = false,
    this.wholesalers = const [],
    this.selected,
    this.errorMessage,
  });

  final bool isLoading;
  final List<WholesalerProfile> wholesalers;
  final WholesalerProfile? selected;
  final String? errorMessage;

  SalesWholesalerState copyWith({
    bool? isLoading,
    List<WholesalerProfile>? wholesalers,
    WholesalerProfile? selected,
    bool clearSelected = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SalesWholesalerState(
      isLoading: isLoading ?? this.isLoading,
      wholesalers: wholesalers ?? this.wholesalers,
      selected: clearSelected ? null : (selected ?? this.selected),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [isLoading, wholesalers, selected, errorMessage];
}
