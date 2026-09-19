import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/b2b_role_resolution.dart';
import '../repositories/b2b_repository.dart';

@lazySingleton
class ResolveAccountRoleUseCase implements UseCase<B2bRoleResolution, String> {
  const ResolveAccountRoleUseCase(this._repository);

  final B2bRepository _repository;

  /// [userId] is the signed-in Supabase auth user id.
  @override
  Future<Result<B2bRoleResolution>> call(String userId) {
    return _repository.resolveRole(userId);
  }
}
