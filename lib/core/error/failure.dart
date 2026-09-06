import 'package:equatable/equatable.dart';

/// Typed failure hierarchy — the only thing above the data layer ever sees.
/// Datasources/repositories catch SDK-specific exceptions (AuthException,
/// PostgrestException, DioException, HiveError) and map them to one of these.
sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Wrong credentials, expired/invalid OTP, unverified email — the user did
/// something the backend rejected, as opposed to the backend being unreachable.
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// No connection, timeout, non-2xx from a route with no more specific meaning.
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// A local Hive read/write threw.
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Input the user gave failed validation before anything was even sent out.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Anything else — still surfaced to the user, never swallowed.
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
