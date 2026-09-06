import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/auth_repository.dart';

class UpdatePasswordUseCase implements UseCase<void, String> {
  const UpdatePasswordUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<void>> call(String newPassword) {
    return _repository.updatePassword(newPassword: newPassword);
  }
}
