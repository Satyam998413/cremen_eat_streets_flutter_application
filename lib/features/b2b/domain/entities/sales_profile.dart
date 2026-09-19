import 'package:equatable/equatable.dart';

/// Mirrors the columns of `sales_profiles` this app needs (cremen_eat_streets
/// B2B ordering channel) — see plans/platform-overview.md Step 4a addendum.
class SalesProfile extends Equatable {
  const SalesProfile({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.status,
    required this.createdBy,
  });

  final String id;
  final String fullName;
  final String phone;
  final String email;
  final String status; // 'active' | 'suspended'
  final String createdBy;

  bool get isActive => status == 'active';

  @override
  List<Object?> get props => [id, fullName, phone, email, status, createdBy];
}
