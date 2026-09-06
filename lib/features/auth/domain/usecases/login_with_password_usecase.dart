import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/customer_profile.dart';
import '../repositories/auth_repository.dart';

class LoginParams {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;
}

class LoginWithPasswordUseCase implements UseCase<CustomerProfile, LoginParams> {
  const LoginWithPasswordUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<CustomerProfile>> call(LoginParams params) {
    return _repository.signInWithPassword(email: params.email, password: params.password);
  }
}
