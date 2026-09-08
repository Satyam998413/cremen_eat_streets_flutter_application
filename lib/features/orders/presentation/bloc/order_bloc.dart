import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../../domain/usecases/get_order_by_public_token_usecase.dart';
import '../../domain/usecases/get_order_history_usecase.dart';
import 'order_event.dart';
import 'order_state.dart';

@lazySingleton
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required GetOrderHistoryUseCase getOrderHistory,
    required GetOrderByPublicTokenUseCase getOrderByPublicToken,
  })  : _getOrderHistory = getOrderHistory,
        _getOrderByPublicToken = getOrderByPublicToken,
        super(const OrderState.initial()) {
    on<OrderHistoryRequested>(_onHistoryRequested);
    on<OrderDetailRequested>(_onDetailRequested);
  }

  final GetOrderHistoryUseCase _getOrderHistory;
  final GetOrderByPublicTokenUseCase _getOrderByPublicToken;

  Future<void> _onHistoryRequested(OrderHistoryRequested event, Emitter<OrderState> emit) async {
    emit(const OrderState.loading());
    final result = await _getOrderHistory(const NoParams());
    switch (result) {
      case Success(:final value):
        emit(OrderState.historyLoaded(value));
      case Failed(:final failure):
        emit(OrderState.failure(failure.message));
    }
  }

  Future<void> _onDetailRequested(OrderDetailRequested event, Emitter<OrderState> emit) async {
    emit(const OrderState.loading());
    final result = await _getOrderByPublicToken(event.publicToken);
    switch (result) {
      case Success(:final value):
        emit(OrderState.detailLoaded(value));
      case Failed(:final failure):
        emit(OrderState.failure(failure.message));
    }
  }
}
