import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/customer_profile.dart';
import '../repositories/auth_repository.dart';

class SignUpParams {
  const SignUpParams({required this.fullName, required this.email, required this.password});

  final String fullName;
  final String email;
  final String password;
}

class SignUpWithPasswordUseCase implements UseCase<CustomerProfile?, SignUpParams> {
  const SignUpWithPasswordUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<CustomerProfile?>> call(SignUpParams params) {
    return _repository.signUpWithPassword(
      fullName: params.fullName,
      email: params.email,
      password: params.password,
    );
  }
}
