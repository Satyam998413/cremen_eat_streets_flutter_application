import 'package:cremen_eatstreet_shop_application/core/theme/theme_cubit.dart';
import 'package:cremen_eatstreet_shop_application/core/widgets/main_shell_screen.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/presentation/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import '../../support/auth_test_support.dart';
import '../../support/hive_test_utils.dart';

void main() {
  setUpAll(() async {
    await initIsolatedHive();
    await Hive.openBox(ThemeCubit.boxName);
    await initTestSupabase();
  });

  Widget buildShell({int initialIndex = 0}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CatalogBloc>(create: (_) => CatalogBloc()),
        BlocProvider<CartBloc>(create: (_) => CartBloc()),
        BlocProvider<OrderBloc>(create: (_) => OrderBloc()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<AuthBloc>(create: (_) => buildTestAuthBloc()),
      ],
      child: MaterialApp(home: MainShellScreen(initialIndex: initialIndex)),
    );
  }

  testWidgets('shows all 4 tabs, with no owner/admin entry point', (tester) async {
    await tester.pumpWidget(buildShell());
    // Home's FoodCard grid has an intentionally infinite spicy-badge shimmer
    // (flutter_animate's `.repeat(reverse: true)`), so pumpAndSettle() would
    // never return — advance a few bounded frames instead.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Cart'), findsOneWidget);
    expect(find.text('Orders'), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
    expect(find.textContaining('Owner'), findsNothing);
  });

  testWidgets('tapping Account switches to the Account screen with a theme switch', (tester) async {
    await tester.pumpWidget(buildShell());
    // Home's FoodCard grid has an intentionally infinite spicy-badge shimmer
    // (flutter_animate's `.repeat(reverse: true)`), so pumpAndSettle() would
    // never return — advance a few bounded frames instead.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('Account'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Appearance'), findsOneWidget);
    expect(find.byType(SegmentedButton<ThemeMode>), findsOneWidget);
  });
}
