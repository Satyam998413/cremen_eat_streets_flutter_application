import '../../../../core/error/result.dart';
import '../entities/customer_profile.dart';

abstract class AuthRepository {
  /// Fires on every session change — including the Google OAuth deep-link
  /// redirect completing, which has no other return point in this app.
  /// `null` means signed out.
  Stream<CustomerProfile?> get authStateChanges;

  CustomerProfile? get currentProfile;

  Future<Result<CustomerProfile>> signInWithPassword({
    required String email,
    required String password,
  });

  /// A `null` value on success means Supabase requires email confirmation
  /// before a session exists yet ("check your inbox"); a non-null value
  /// means the account is already usable immediately.
  Future<Result<CustomerProfile?>> signUpWithPassword({
    required String fullName,
    required String email,
    required String password,
  });

  /// Login only — never creates a new account. Mirrors the website's OTP
  /// login *intent*, not its exact mechanism: this uses Supabase's own
  /// native email-OTP delivery/rate-limiting rather than the website's
  /// bespoke `otp_verifications` table, so a code requested here has no
  /// relationship to one requested on the website. The end result (a real
  /// session against the same customer_profiles row) is identical either way.
  Future<Result<void>> requestEmailOtp({required String email});

  Future<Result<CustomerProfile>> verifyEmailOtp({
    required String email,
    required String token,
  });

  /// Opens the browser-based Google OAuth flow; the resulting session (or
  /// failure) arrives later via [authStateChanges], not this call's return.
  Future<Result<void>> signInWithGoogle();

  Future<Result<void>> requestPasswordReset({required String email});

  Future<Result<void>> updatePassword({required String newPassword});

  Future<Result<CustomerProfile>> completeProfile({
    required String fullName,
    required String mobileNumber,
  });

  /// Links any pre-signup guest orders matching this customer's email/phone —
  /// mirrors the web app's `claim_guest_orders` RPC call on every login/signup.
  Future<Result<void>> claimGuestOrders();

  Future<void> signOut();
}
