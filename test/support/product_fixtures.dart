import 'package:cremen_eatstreet_shop_application/core/error/result.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/entities/product.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/get_catalog_usecase.dart';

/// A minimal, valid Product for tests that don't care about every field.
Product buildTestProduct({
  String id = 'p1',
  String name = 'Demo Snack',
  double basePrice = 50,
  bool isSpicy = true,
  bool? isVeg,
  List<ProductVariant> variants = const [],
}) {
  return Product(
    id: id,
    productType: 'packaged',
    slug: id,
    name: name,
    description: 'A tasty demo item',
    basePrice: basePrice,
    isSpicy: isSpicy,
    isVeg: isVeg,
    variants: variants,
    media: const [ProductMedia(url: 'assets/images/cremen_logo.jpg', isPrimary: true)],
  );
}

class _EmptyCatalogRepository implements CatalogRepository {
  @override
  Future<Result<List<Product>>> getCatalog() async => const Success([]);
}

/// For widget smoke tests that need a CatalogBloc in context but don't
/// exercise catalog behavior themselves — never hits the network.
GetCatalogUseCase buildTestGetCatalogUseCase() => GetCatalogUseCase(_EmptyCatalogRepository());
