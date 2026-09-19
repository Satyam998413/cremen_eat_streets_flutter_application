import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/wholesaler_profile.dart';
import '../repositories/b2b_repository.dart';

@lazySingleton
class GetAssignedWholesalersUseCase implements UseCase<List<WholesalerProfile>, String> {
  const GetAssignedWholesalersUseCase(this._repository);

  final B2bRepository _repository;

  /// [salesId] is the signed-in salesman's own user id.
  @override
  Future<Result<List<WholesalerProfile>>> call(String salesId) {
    return _repository.getAssignedWholesalers(salesId);
  }
}
