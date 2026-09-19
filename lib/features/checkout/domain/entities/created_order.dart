import 'package:equatable/equatable.dart';

/// What `POST /api/checkout/create-order` returns — see
/// plans/platform-overview.md (cremen_eat_streets), Step 10.
///
/// Two distinct success shapes share this one entity: the everyday Razorpay
/// path (every retail-channel field non-null, [codConfirmed] false) and the
/// B2B cash-on-delivery path (only [orderId]/[publicToken]/[codConfirmed]
/// populated — the order is already placed server-side with nothing left to
/// pay online). The Razorpay-only fields are nullable rather than this being
/// two separate entities/states because [CheckoutBloc] only needs a single
/// three-way branch (cod vs. razorpay vs. failure), not a whole parallel
/// state machine.
class CreatedOrder extends Equatable {
  const CreatedOrder({
    required this.orderId,
    this.razorpayOrderId,
    this.amount,
    this.currency,
    this.keyId,
    this.prefillName,
    this.prefillContact,
    this.prefillEmail,
    this.codConfirmed = false,
    this.publicToken,
  });

  final String orderId;
  final String? razorpayOrderId;
  final int? amount; // paise
  final String? currency;
  final String? keyId;
  final String? prefillName;
  final String? prefillContact;
  final String? prefillEmail;

  /// True only for a B2B (sales/wholesale) order placed with
  /// `paymentMethod: 'cod'` — the order is already confirmed, skip Razorpay
  /// entirely and go straight to order confirmation with [publicToken].
  final bool codConfirmed;
  final String? publicToken;

  @override
  List<Object?> get props => [
        orderId,
        razorpayOrderId,
        amount,
        currency,
        keyId,
        prefillName,
        prefillContact,
        prefillEmail,
        codConfirmed,
        publicToken,
      ];
}
