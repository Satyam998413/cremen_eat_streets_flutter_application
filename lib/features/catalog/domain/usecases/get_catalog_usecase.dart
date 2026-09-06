import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/product.dart';
import '../repositories/catalog_repository.dart';

class GetCatalogUseCase implements UseCase<List<Product>, NoParams> {
  const GetCatalogUseCase(this._repository);

  final CatalogRepository _repository;

  @override
  Future<Result<List<Product>>> call(NoParams params) {
    return _repository.getCatalog();
  }
}
