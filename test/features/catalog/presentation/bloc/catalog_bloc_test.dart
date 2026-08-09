import 'package:flutter_test/flutter_test.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/bloc/catalog_event.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/bloc/catalog_state.dart';

void main() {
  group('CatalogBloc Tests', () {
    late CatalogBloc catalogBloc;

    setUp(() {
      catalogBloc = CatalogBloc();
    });

    tearDown(() {
      catalogBloc.close();
    });

    test('initial state is CatalogInitial', () {
      expect(catalogBloc.state, equals(CatalogInitial()));
    });

    test('emits CatalogLoaded when CatalogStarted is added', () async {
      catalogBloc.add(CatalogStarted());

      await expectLater(
        catalogBloc.stream,
        emitsInOrder([
          isA<CatalogLoading>(),
          isA<CatalogLoaded>(),
        ]),
      );
    });
  });
}
