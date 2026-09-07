import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.freezed.dart';

@freezed
sealed class OrderEvent with _$OrderEvent {
  const factory OrderEvent.historyRequested() = OrderHistoryRequested;
  const factory OrderEvent.detailRequested(String publicToken) = OrderDetailRequested;
}
