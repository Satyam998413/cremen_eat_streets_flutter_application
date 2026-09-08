import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class RequestOtpUseCase implements UseCase<void, String> {
  const RequestOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<void>> call(String email) {
    return _repository.requestEmailOtp(email: email);
  }
}
