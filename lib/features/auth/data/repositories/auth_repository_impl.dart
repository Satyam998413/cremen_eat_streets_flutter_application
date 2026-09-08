import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show AuthException, PostgrestException, User;
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/customer_profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote);

  final AuthRemoteDataSource _remote;

  @override
  Stream<CustomerProfile?> get authStateChanges {
    return _remote.onAuthStateChange.asyncMap((state) {
      final user = state.session?.user;
      if (user == null) return Future.value(null);
      return _loadProfile(user);
    });
  }

  @override
  CustomerProfile? get currentProfile {
    // Synchronous best-effort snapshot for app-start routing decisions, built
    // from the JWT alone — the async authStateChanges stream is the source
    // of truth once the customer_profiles row has actually loaded.
    final user = _remote.currentUser;
    return user == null ? null : _profileFromAuthUser(user);
  }

  CustomerProfile _profileFromAuthUser(User user) {
    return CustomerProfile(
      id: user.id,
      fullName: (user.userMetadata?['full_name'] as String?) ?? '',
      email: user.email ?? '',
      authProvider: (user.appMetadata['provider'] as String?) ?? 'password',
    );
  }

  Future<CustomerProfile> _loadProfile(User user) async {
    var row = await _remote.fetchCustomerProfile(user.id);
    if (row == null) {
      // No customer_profiles row yet — this session is brand new (a password
      // signup that got an immediate session, or a first-time Google
      // sign-in). Create it now via the one RPC that's allowed to.
      final provider = (user.appMetadata['provider'] as String?) ?? 'password';
      await _remote.ensureCustomerProfile(
        fullName: (user.userMetadata?['full_name'] as String?) ?? '',
        email: user.email ?? '',
        authProvider: provider == 'google' ? 'google' : 'password',
      );
      row = await _remote.fetchCustomerProfile(user.id);
    }
    if (row == null) return _profileFromAuthUser(user);
    return CustomerProfile(
      id: user.id,
      fullName: row['full_name'] as String? ?? '',
      email: row['email'] as String? ?? user.email ?? '',
      authProvider: row['auth_provider'] as String? ?? 'password',
      mobileNumber: row['mobile_number'] as String?,
      mobileVerified: row['mobile_verified'] as bool? ?? false,
      address: row['address'] as Map<String, dynamic>?,
    );
  }

  @override
  Future<Result<CustomerProfile>> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remote.signInWithPassword(email: email, password: password);
      final user = response.user;
      if (user == null) return const Failed(AuthFailure('Login failed. Please try again.'));
      return Success(await _loadProfile(user));
    } on AuthException catch (e) {
      return Failed(AuthFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<CustomerProfile?>> signUpWithPassword({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remote.signUpWithPassword(
        fullName: fullName,
        email: email,
        password: password,
      );
      final user = response.user;
      // No session yet means Supabase's "Confirm email" setting is on — the
      // account exists but can't be used (or profiled) until the user clicks
      // the emailed confirmation link and logs in.
      if (user == null || response.session == null) return const Success(null);
      return Success(await _loadProfile(user));
    } on AuthException catch (e) {
      return Failed(AuthFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> requestEmailOtp({required String email}) async {
    try {
      await _remote.requestEmailOtp(email: email);
      return const Success(null);
    } on AuthException catch (e) {
      return Failed(AuthFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<CustomerProfile>> verifyEmailOtp({required String email, required String token}) async {
    try {
      final response = await _remote.verifyEmailOtp(email: email, token: token);
      final user = response.user;
      if (user == null) return const Failed(AuthFailure('Incorrect or expired code.'));
      return Success(await _loadProfile(user));
    } on AuthException catch (e) {
      return Failed(AuthFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> signInWithGoogle() async {
    try {
      await _remote.signInWithGoogle();
      return const Success(null);
    } on AuthException catch (e) {
      return Failed(AuthFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> requestPasswordReset({required String email}) async {
    try {
      await _remote.requestPasswordReset(email: email);
      return const Success(null);
    } on AuthException catch (e) {
      return Failed(AuthFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> updatePassword({required String newPassword}) async {
    try {
      await _remote.updatePassword(newPassword: newPassword);
      return const Success(null);
    } on AuthException catch (e) {
      return Failed(AuthFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<CustomerProfile>> completeProfile({
    required String fullName,
    required String mobileNumber,
  }) async {
    final user = _remote.currentUser;
    if (user == null) return const Failed(AuthFailure('You are not signed in.'));
    try {
      await _remote.updateCustomerFullName(user.id, fullName);
      await _remote.verifyCustomerMobile(mobileNumber);
      return Success(await _loadProfile(user));
    } on PostgrestException catch (e) {
      return Failed(UnknownFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<CustomerProfile>> updateFullName(String fullName) async {
    final user = _remote.currentUser;
    if (user == null) return const Failed(AuthFailure('You are not signed in.'));
    try {
      await _remote.updateCustomerFullName(user.id, fullName);
      return Success(await _loadProfile(user));
    } on PostgrestException catch (e) {
      return Failed(UnknownFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Result<void>> claimGuestOrders() async {
    final user = _remote.currentUser;
    if (user == null) return const Failed(AuthFailure('You are not signed in.'));
    try {
      await _remote.claimGuestOrders(user.id);
      return const Success(null);
    } on PostgrestException catch (e) {
      return Failed(UnknownFailure(e.message));
    } catch (e) {
      return Failed(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<void> signOut() => _remote.signOut();
}
