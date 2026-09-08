import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../../domain/entities/customer_profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/claim_guest_orders_usecase.dart';
import '../../domain/usecases/complete_profile_usecase.dart';
import '../../domain/usecases/login_with_password_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/request_otp_usecase.dart';
import '../../domain/usecases/request_password_reset_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../../domain/usecases/sign_up_with_password_usecase.dart';
import '../../domain/usecases/update_full_name_usecase.dart';
import '../../domain/usecases/update_password_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository repository,
    required LoginWithPasswordUseCase loginWithPassword,
    required SignUpWithPasswordUseCase signUpWithPassword,
    required RequestOtpUseCase requestOtp,
    required VerifyOtpUseCase verifyOtp,
    required SignInWithGoogleUseCase signInWithGoogle,
    required RequestPasswordResetUseCase requestPasswordReset,
    required UpdatePasswordUseCase updatePassword,
    required CompleteProfileUseCase completeProfile,
    required UpdateFullNameUseCase updateFullName,
    required ClaimGuestOrdersUseCase claimGuestOrders,
    required LogoutUseCase logout,
  })  : _repository = repository,
        _loginWithPassword = loginWithPassword,
        _signUpWithPassword = signUpWithPassword,
        _requestOtp = requestOtp,
        _verifyOtp = verifyOtp,
        _signInWithGoogle = signInWithGoogle,
        _requestPasswordReset = requestPasswordReset,
        _updatePassword = updatePassword,
        _completeProfile = completeProfile,
        _updateFullName = updateFullName,
        _claimGuestOrders = claimGuestOrders,
        _logout = logout,
        super(const AuthState.loading()) {
    on<AuthSessionChecked>(_onSessionChecked);
    on<AuthLoggedInWithPassword>(_onLoggedInWithPassword);
    on<AuthSignedUpWithPassword>(_onSignedUpWithPassword);
    on<AuthOtpRequested>(_onOtpRequested);
    on<AuthOtpVerified>(_onOtpVerified);
    on<AuthGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AuthPasswordResetRequested>(_onPasswordResetRequested);
    on<AuthPasswordUpdated>(_onPasswordUpdated);
    on<AuthProfileCompleted>(_onProfileCompleted);
    on<AuthFullNameUpdated>(_onFullNameUpdated);
    on<AuthLoggedOut>(_onLoggedOut);
    on<AuthExternalSessionChanged>(_onExternalSessionChanged);

    _authSubscription = _repository.authStateChanges.listen(
      (profile) => add(AuthEvent.externalSessionChanged(profile)),
    );

    add(const AuthEvent.sessionChecked());
  }

  final AuthRepository _repository;
  final LoginWithPasswordUseCase _loginWithPassword;
  final SignUpWithPasswordUseCase _signUpWithPassword;
  final RequestOtpUseCase _requestOtp;
  final VerifyOtpUseCase _verifyOtp;
  final SignInWithGoogleUseCase _signInWithGoogle;
  final RequestPasswordResetUseCase _requestPasswordReset;
  final UpdatePasswordUseCase _updatePassword;
  final CompleteProfileUseCase _completeProfile;
  final UpdateFullNameUseCase _updateFullName;
  final ClaimGuestOrdersUseCase _claimGuestOrders;
  final LogoutUseCase _logout;
  late final StreamSubscription<CustomerProfile?> _authSubscription;

  Future<void> _onSessionChecked(AuthSessionChecked event, Emitter<AuthState> emit) async {
    emit(_stateFor(_repository.currentProfile));
  }

  Future<void> _onLoggedInWithPassword(AuthLoggedInWithPassword event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _loginWithPassword(LoginParams(email: event.email, password: event.password));
    await _handleProfileResult(result, emit);
  }

  Future<void> _onSignedUpWithPassword(AuthSignedUpWithPassword event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _signUpWithPassword(
      SignUpParams(fullName: event.fullName, email: event.email, password: event.password),
    );
    switch (result) {
      case Success(:final value):
        // A null profile means Supabase's "Confirm email" setting is on —
        // there's no session yet, so there's nothing to route into.
        if (value == null) {
          emit(AuthState.signupPending(event.email));
        } else {
          await _claimGuestOrders(const NoParams());
          emit(_stateFor(value));
        }
      case Failed(:final failure):
        emit(AuthState.error(failure.message));
    }
  }

  Future<void> _onOtpRequested(AuthOtpRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _requestOtp(event.email);
    switch (result) {
      case Success():
        emit(AuthState.otpSent(event.email));
      case Failed(:final failure):
        emit(AuthState.error(failure.message));
    }
  }

  Future<void> _onOtpVerified(AuthOtpVerified event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _verifyOtp(VerifyOtpParams(email: event.email, token: event.token));
    await _handleProfileResult(result, emit);
  }

  Future<void> _onGoogleSignInRequested(AuthGoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _signInWithGoogle(const NoParams());
    // Success here only means the browser flow opened — the resulting
    // session (or its absence, if the user cancels) arrives later through
    // _onExternalSessionChanged via authStateChanges, not this call.
    if (result case Failed(:final failure)) {
      emit(AuthState.error(failure.message));
    }
  }

  Future<void> _onPasswordResetRequested(AuthPasswordResetRequested event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _requestPasswordReset(event.email);
    switch (result) {
      case Success():
        emit(const AuthState.passwordResetEmailSent());
      case Failed(:final failure):
        emit(AuthState.error(failure.message));
    }
  }

  Future<void> _onPasswordUpdated(AuthPasswordUpdated event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _updatePassword(event.newPassword);
    switch (result) {
      case Success():
        emit(_stateFor(_repository.currentProfile));
      case Failed(:final failure):
        emit(AuthState.error(failure.message));
    }
  }

  Future<void> _onProfileCompleted(AuthProfileCompleted event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _completeProfile(
      CompleteProfileParams(fullName: event.fullName, mobileNumber: event.mobileNumber),
    );
    await _handleProfileResult(result, emit);
  }

  Future<void> _onFullNameUpdated(AuthFullNameUpdated event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());
    final result = await _updateFullName(event.fullName);
    switch (result) {
      case Success(:final value):
        emit(_stateFor(value));
      case Failed(:final failure):
        emit(AuthState.error(failure.message));
    }
  }

  Future<void> _onLoggedOut(AuthLoggedOut event, Emitter<AuthState> emit) async {
    await _logout(const NoParams());
    emit(const AuthState.unauthenticated());
  }

  Future<void> _onExternalSessionChanged(AuthExternalSessionChanged event, Emitter<AuthState> emit) async {
    final profile = event.profile;
    if (profile != null && !profile.needsProfileCompletion) {
      // A brand-new session appearing here (as opposed to via one of this
      // bloc's own login handlers) only happens after the Google OAuth
      // deep-link redirect — claim any guest orders now, same as every
      // other login path does in _handleProfileResult.
      await _claimGuestOrders(const NoParams());
    }
    emit(_stateFor(profile));
  }

  Future<void> _handleProfileResult(Result<CustomerProfile> result, Emitter<AuthState> emit) async {
    switch (result) {
      case Success(:final value):
        if (!value.needsProfileCompletion) {
          await _claimGuestOrders(const NoParams());
        }
        emit(_stateFor(value));
      case Failed(:final failure):
        emit(AuthState.error(failure.message));
    }
  }

  AuthState _stateFor(CustomerProfile? profile) {
    if (profile == null) return const AuthState.unauthenticated();
    if (profile.needsProfileCompletion) return AuthState.needsProfileCompletion(profile);
    return AuthState.authenticated(profile);
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
