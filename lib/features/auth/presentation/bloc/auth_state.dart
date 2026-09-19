import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../b2b/domain/entities/sales_profile.dart';
import '../../../b2b/domain/entities/wholesaler_profile.dart';
import '../../domain/entities/account_role.dart';
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

  /// [role] defaults to customer and is resolved asynchronously right after
  /// this state first becomes Authenticated (see AuthBloc._emitForProfile) —
  /// there's a brief window where an actual salesman/wholesaler shows as
  /// `customer` while that lookup is in flight, same tradeoff as
  /// `currentProfile`'s own "best-effort from the JWT alone" comment already
  /// accepts for the customer profile itself.
  const factory AuthState.authenticated(
    CustomerProfile profile, {
    @Default(AccountRole.customer) AccountRole role,
    SalesProfile? salesProfile,
    WholesalerProfile? wholesalerProfile,
  }) = Authenticated;
  const factory AuthState.error(String message) = AuthError;
}
