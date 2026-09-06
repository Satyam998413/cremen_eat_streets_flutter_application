import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/customer_profile.dart';

part 'auth_event.freezed.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.sessionChecked() = AuthSessionChecked;
  const factory AuthEvent.loggedInWithPassword(String email, String password) = AuthLoggedInWithPassword;
  const factory AuthEvent.signedUpWithPassword(String fullName, String email, String password) =
      AuthSignedUpWithPassword;
  const factory AuthEvent.otpRequested(String email) = AuthOtpRequested;
  const factory AuthEvent.otpVerified(String email, String token) = AuthOtpVerified;
  const factory AuthEvent.googleSignInRequested() = AuthGoogleSignInRequested;
  const factory AuthEvent.passwordResetRequested(String email) = AuthPasswordResetRequested;
  const factory AuthEvent.passwordUpdated(String newPassword) = AuthPasswordUpdated;
  const factory AuthEvent.profileCompleted(String fullName, String mobileNumber) = AuthProfileCompleted;
  const factory AuthEvent.loggedOut() = AuthLoggedOut;

  /// Internal — raised whenever the repository's own session stream fires
  /// (a Google OAuth deep-link redirect completing, a token refresh, or a
  /// revoked session) rather than as the direct result of one of the events
  /// above.
  const factory AuthEvent.externalSessionChanged(CustomerProfile? profile) = AuthExternalSessionChanged;
}
