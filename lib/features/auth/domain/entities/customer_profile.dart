import 'package:equatable/equatable.dart';

/// Mirrors the columns of `customer_profiles` this app actually needs — see
/// plans/platform-overview.md (cremen_eat_streets) Step 4a for the full table.
class CustomerProfile extends Equatable {
  const CustomerProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.authProvider,
    this.mobileNumber,
    this.mobileVerified = false,
    this.address,
  });

  final String id;
  final String fullName;
  final String email;
  final String authProvider; // 'password' | 'google' | 'otp'
  final String? mobileNumber;
  final bool mobileVerified;
  final Map<String, dynamic>? address;

  /// Google sign-ins land without a verified mobile number — every other
  /// path (password, email OTP) already required one, so only this
  /// combination ever needs the Complete Profile gate.
  bool get needsProfileCompletion => authProvider == 'google' && !mobileVerified;

  CustomerProfile copyWith({
    String? fullName,
    String? mobileNumber,
    bool? mobileVerified,
    Map<String, dynamic>? address,
  }) {
    return CustomerProfile(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email,
      authProvider: authProvider,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      mobileVerified: mobileVerified ?? this.mobileVerified,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        authProvider,
        mobileNumber,
        mobileVerified,
        address,
      ];
}
