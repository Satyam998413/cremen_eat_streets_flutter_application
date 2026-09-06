import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/auth_repository.dart';

class ClaimGuestOrdersUseCase implements UseCase<void, NoParams> {
  const ClaimGuestOrdersUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<void>> call(NoParams params) {
    return _repository.claimGuestOrders();
  }
}
