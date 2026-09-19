import 'package:equatable/equatable.dart';

/// Mirrors the columns of `wholesaler_profiles` this app needs
/// (cremen_eat_streets B2B ordering channel).
class WholesalerProfile extends Equatable {
  const WholesalerProfile({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.status,
    required this.createdBy,
    required this.createdByRole,
    this.businessName,
    this.gstNumber,
    this.assignedSalesId,
    this.address,
  });

  final String id;
  final String fullName;
  final String? businessName;
  final String phone;
  final String email;
  final String? gstNumber;
  final String status; // 'active' | 'suspended'
  final String? assignedSalesId;
  final String createdBy;
  final String createdByRole; // 'admin' | 'salesman'

  /// Raw passthrough of the `address` jsonb column — same
  /// {line1,line2,city,state,pincode,lat,lng} shape as orders.shipping_address
  /// (see FoodOrder.shippingAddress). No dedicated typed class, same call as
  /// the rest of this app for that column shape.
  final Map<String, dynamic>? address;

  bool get isActive => status == 'active';

  /// What a salesman's wholesaler picker should show for this row.
  String get displayName => (businessName != null && businessName!.isNotEmpty) ? businessName! : fullName;

  /// "City, State" for display, or null if no address was recorded.
  String? get addressSummary {
    final city = address?['city'] as String?;
    final state = address?['state'] as String?;
    if (city == null || city.isEmpty) return null;
    return (state != null && state.isNotEmpty) ? '$city, $state' : city;
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        businessName,
        phone,
        email,
        gstNumber,
        status,
        assignedSalesId,
        createdBy,
        createdByRole,
        address,
      ];
}
