import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogleUseCase implements UseCase<void, NoParams> {
  const SignInWithGoogleUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<void>> call(NoParams params) {
    return _repository.signInWithGoogle();
  }
}
