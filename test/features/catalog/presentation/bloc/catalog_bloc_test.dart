import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cremen_eatstreet_shop_application/core/error/failure.dart';
import 'package:cremen_eatstreet_shop_application/core/error/result.dart';
import 'package:cremen_eatstreet_shop_application/core/usecases/use_case.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/get_catalog_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/bloc/catalog_event.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/bloc/catalog_state.dart';
import '../../../../support/product_fixtures.dart';

class _MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  late _MockCatalogRepository repository;
  late GetCatalogUseCase getCatalog;

  setUpAll(() {
    registerFallbackValue(const NoParams());
  });

  setUp(() {
    repository = _MockCatalogRepository();
    getCatalog = GetCatalogUseCase(repository);
  });

  final products = [buildTestProduct(id: 'p1'), buildTestProduct(id: 'p2', name: 'Other')];

  blocTest<CatalogBloc, CatalogState>(
    'emits [loading, loaded] when CatalogRequested succeeds',
    setUp: () => when(() => repository.getCatalog()).thenAnswer((_) async => Success(products)),
    build: () => CatalogBloc(getCatalog),
    act: (bloc) => bloc.add(const CatalogEvent.requested()),
    expect: () => [
      const CatalogState.loading(),
      CatalogState.loaded(products: products),
    ],
  );

  blocTest<CatalogBloc, CatalogState>(
    'emits [loading, failure] when CatalogRequested fails',
    setUp: () => when(() => repository.getCatalog())
        .thenAnswer((_) async => const Failed(NetworkFailure('offline'))),
    build: () => CatalogBloc(getCatalog),
    act: (bloc) => bloc.add(const CatalogEvent.requested()),
    expect: () => [
      const CatalogState.loading(),
      const CatalogState.failure('offline'),
    ],
  );

  blocTest<CatalogBloc, CatalogState>(
    'filteredProducts narrows by product type and search query',
    setUp: () => when(() => repository.getCatalog()).thenAnswer((_) async => Success(products)),
    build: () => CatalogBloc(getCatalog),
    act: (bloc) => bloc
      ..add(const CatalogEvent.requested())
      ..add(const CatalogEvent.searchQueryChanged('Other')),
    verify: (bloc) {
      final state = bloc.state as CatalogLoaded;
      expect(state.filteredProducts.map((p) => p.id), ['p2']);
    },
  );
}
