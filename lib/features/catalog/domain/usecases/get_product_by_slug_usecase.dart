import 'package:injectable/injectable.dart';
import '../../../../core/error/result.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/product.dart';
import '../repositories/catalog_repository.dart';

@lazySingleton
class GetProductBySlugUseCase implements UseCase<Product, String> {
  const GetProductBySlugUseCase(this._repository);

  final CatalogRepository _repository;

  @override
  Future<Result<Product>> call(String slug) {
    return _repository.getProductBySlug(slug);
  }
}
