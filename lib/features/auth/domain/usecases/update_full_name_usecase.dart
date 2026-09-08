import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/customer_profile.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class UpdateFullNameUseCase implements UseCase<CustomerProfile, String> {
  const UpdateFullNameUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<CustomerProfile>> call(String fullName) {
    return _repository.updateFullName(fullName);
  }
}
