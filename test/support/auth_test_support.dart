import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cremen_eatstreet_shop_application/core/config/app_config.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:cremen_eatstreet_shop_application/features/b2b/data/datasources/b2b_remote_datasource.dart';
import 'package:cremen_eatstreet_shop_application/features/b2b/data/repositories/b2b_repository_impl.dart';
import 'package:cremen_eatstreet_shop_application/features/b2b/domain/usecases/resolve_account_role_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/domain/repositories/auth_repository.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/claim_guest_orders_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/complete_profile_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/login_with_password_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/logout_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/request_otp_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/request_password_reset_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/sign_up_with_password_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/update_full_name_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/presentation/bloc/auth_bloc.dart';

bool _supabaseInitialized = false;

/// Ensures Supabase.instance is available for tests that pump a widget tree
/// needing an AuthBloc, without making any real network call itself.
/// Mocks the shared_preferences platform channel Supabase's session storage
/// needs — plain `flutter test` has no real platform to answer it.
Future<void> initTestSupabase() async {
  if (_supabaseInitialized) return;
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await Supabase.initialize(url: AppConfig.supabaseUrl, publishableKey: AppConfig.supabaseAnonKey);
  _supabaseInitialized = true;
}

/// A real AuthBloc wired against the real Supabase client — with no session
/// present, it starts (and stays, for these UI-smoke-test purposes) unauthenticated.
/// [resolveAccountRole] is never actually invoked in that state (AuthBloc only
/// calls it once a real profile exists), so wiring it against the same real
/// Supabase client is enough — no fake/mock needed.
AuthBloc buildTestAuthBloc() {
  final AuthRepository repository = AuthRepositoryImpl(AuthRemoteDataSource(Supabase.instance.client));
  final b2bRepository = B2bRepositoryImpl(B2bRemoteDataSource(Supabase.instance.client));
  return AuthBloc(
    repository: repository,
    loginWithPassword: LoginWithPasswordUseCase(repository),
    signUpWithPassword: SignUpWithPasswordUseCase(repository),
    requestOtp: RequestOtpUseCase(repository),
    verifyOtp: VerifyOtpUseCase(repository),
    signInWithGoogle: SignInWithGoogleUseCase(repository),
    requestPasswordReset: RequestPasswordResetUseCase(repository),
    updatePassword: UpdatePasswordUseCase(repository),
    completeProfile: CompleteProfileUseCase(repository),
    updateFullName: UpdateFullNameUseCase(repository),
    claimGuestOrders: ClaimGuestOrdersUseCase(repository),
    logout: LogoutUseCase(repository),
    resolveAccountRole: ResolveAccountRoleUseCase(b2bRepository),
  );
}
