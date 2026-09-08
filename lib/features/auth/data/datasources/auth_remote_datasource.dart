import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// The custom scheme this app registers on Android/iOS so Supabase's OAuth
/// flow can redirect back into the app after Google sign-in completes.
/// Must also be added to Supabase Dashboard → Authentication → URL
/// Configuration → Redirect URLs (a one-time step only the project owner can
/// do, tracked as a manual follow-up).
const googleOAuthRedirectUri = 'com.cremeneatstreet.shop://login-callback';

/// Thin wrapper around the Supabase SDK calls this feature needs. Throws the
/// SDK's own exceptions (AuthException, PostgrestException) — mapping those
/// to a typed Failure is the repository's job, not this datasource's.
@lazySingleton
class AuthRemoteDataSource {
  AuthRemoteDataSource(this._client);

  final SupabaseClient _client;

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;

  Future<AuthResponse> signInWithPassword({required String email, required String password}) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<AuthResponse> signUpWithPassword({
    required String fullName,
    required String email,
    required String password,
  }) {
    return _client.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );
  }

  Future<void> requestEmailOtp({required String email}) {
    // shouldCreateUser: false — OTP is a *login* path only in this app; a
    // brand-new account always goes through signUpWithPassword instead, so
    // its customer_profiles row gets created via ensureCustomerProfile below.
    return _client.auth.signInWithOtp(email: email, shouldCreateUser: false);
  }

  Future<AuthResponse> verifyEmailOtp({required String email, required String token}) {
    return _client.auth.verifyOTP(email: email, token: token, type: OtpType.email);
  }

  Future<bool> signInWithGoogle() {
    return _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: googleOAuthRedirectUri,
    );
  }

  Future<void> requestPasswordReset({required String email}) {
    return _client.auth.resetPasswordForEmail(email);
  }

  Future<UserResponse> updatePassword({required String newPassword}) {
    return _client.auth.updateUser(UserAttributes(password: newPassword));
  }

  Future<Map<String, dynamic>?> fetchCustomerProfile(String userId) {
    return _client.from('customer_profiles').select().eq('id', userId).maybeSingle();
  }

  /// Requires the `ensure_customer_profile(p_full_name, p_email,
  /// p_auth_provider)` SECURITY DEFINER RPC from
  /// supabase/migrations/015_mobile_client_profile_bootstrap.sql (cremen_eat_streets)
  /// — NOT YET applied to the live project as of this writing. customer_profiles
  /// has no INSERT policy for `authenticated` (only service_role, which this app
  /// can never hold), so this is the only way a brand-new session (password
  /// signup once "Confirm email" allows an immediate session, or a first-time
  /// Google sign-in) can create its own profile row.
  Future<void> ensureCustomerProfile({
    required String fullName,
    required String email,
    required String authProvider,
  }) {
    return _client.rpc('ensure_customer_profile', params: {
      'p_full_name': fullName,
      'p_email': email,
      'p_auth_provider': authProvider,
    });
  }

  Future<void> updateCustomerFullName(String userId, String fullName) {
    return _client.from('customer_profiles').update({'full_name': fullName}).eq('id', userId);
  }

  /// Requires the `verify_customer_mobile(p_mobile_number)` SECURITY DEFINER
  /// RPC from supabase/migrations/015_mobile_client_profile_bootstrap.sql
  /// (cremen_eat_streets) — NOT YET applied to the live project as of this
  /// writing. `customer_profiles_protect_columns` reverts a direct client
  /// update to `mobile_number`/`mobile_verified` for any non-service_role
  /// caller; this RPC is the one narrow, self-scoped exception to that lock.
  Future<void> verifyCustomerMobile(String mobileNumber) {
    return _client.rpc('verify_customer_mobile', params: {
      'p_mobile_number': mobileNumber,
    });
  }

  Future<void> claimGuestOrders(String userId) {
    return _client.rpc('claim_guest_orders', params: {'p_user_id': userId});
  }

  Future<void> signOut() => _client.auth.signOut();
}
