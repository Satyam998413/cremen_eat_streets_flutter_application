import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/customer_profile.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpParams {
  const VerifyOtpParams({required this.email, required this.token});

  final String email;
  final String token;
}

class VerifyOtpUseCase implements UseCase<CustomerProfile, VerifyOtpParams> {
  const VerifyOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<CustomerProfile>> call(VerifyOtpParams params) {
    return _repository.verifyEmailOtp(email: params.email, token: params.token);
  }
}
