import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class RequestPasswordResetUseCase implements UseCase<void, String> {
  const RequestPasswordResetUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<void>> call(String email) {
    return _repository.requestPasswordReset(email: email);
  }
}
