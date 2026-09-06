import 'package:equatable/equatable.dart';

/// What `POST /api/checkout/create-order` returns — see
/// plans/platform-overview.md (cremen_eat_streets), Step 10.
class CreatedOrder extends Equatable {
  const CreatedOrder({
    required this.orderId,
    required this.razorpayOrderId,
    required this.amount,
    required this.currency,
    required this.keyId,
    required this.prefillName,
    required this.prefillContact,
    this.prefillEmail,
  });

  final String orderId;
  final String razorpayOrderId;
  final int amount; // paise
  final String currency;
  final String keyId;
  final String prefillName;
  final String prefillContact;
  final String? prefillEmail;

  @override
  List<Object?> get props =>
      [orderId, razorpayOrderId, amount, currency, keyId, prefillName, prefillContact, prefillEmail];
}
