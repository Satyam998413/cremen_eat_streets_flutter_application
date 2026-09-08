import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/customer_profile.dart';
import '../repositories/auth_repository.dart';

class CompleteProfileParams {
  const CompleteProfileParams({required this.fullName, required this.mobileNumber});

  final String fullName;
  final String mobileNumber;
}

@lazySingleton
class CompleteProfileUseCase implements UseCase<CustomerProfile, CompleteProfileParams> {
  const CompleteProfileUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<CustomerProfile>> call(CompleteProfileParams params) {
    return _repository.completeProfile(fullName: params.fullName, mobileNumber: params.mobileNumber);
  }
}
