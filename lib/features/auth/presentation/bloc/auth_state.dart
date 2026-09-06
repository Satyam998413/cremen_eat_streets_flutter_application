import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/customer_profile.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.otpSent(String email) = AuthOtpSent;
  const factory AuthState.signupPending(String email) = AuthSignupPending;
  const factory AuthState.passwordResetEmailSent() = AuthPasswordResetEmailSent;
  const factory AuthState.needsProfileCompletion(CustomerProfile profile) = AuthNeedsProfileCompletion;
  const factory AuthState.authenticated(CustomerProfile profile) = Authenticated;
  const factory AuthState.error(String message) = AuthError;
}
