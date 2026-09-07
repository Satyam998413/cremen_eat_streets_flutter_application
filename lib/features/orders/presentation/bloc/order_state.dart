import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/food_order.dart';

part 'order_state.freezed.dart';

@freezed
sealed class OrderState with _$OrderState {
  const factory OrderState.initial() = OrderInitial;
  const factory OrderState.loading() = OrderLoading;
  const factory OrderState.historyLoaded(List<FoodOrder> orders) = OrderHistoryLoaded;
  const factory OrderState.detailLoaded(FoodOrder order) = OrderDetailLoaded;
  const factory OrderState.failure(String message) = OrderFailure;
}
