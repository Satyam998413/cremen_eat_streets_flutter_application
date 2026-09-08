import 'package:cremen_eatstreet_shop_application/core/theme/theme_cubit.dart';
import 'package:cremen_eatstreet_shop_application/core/widgets/main_shell_screen.dart';
import 'package:cremen_eatstreet_shop_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/presentation/bloc/order_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import '../../support/auth_test_support.dart';
import '../../support/hive_test_utils.dart';
import '../../support/order_fixtures.dart';
import '../../support/product_fixtures.dart';

void main() {
  setUpAll(() async {
    await initIsolatedHive();
    await Hive.openBox(ThemeCubit.boxName);
    await initTestSupabase();
  });

  // flutter_test's defaultTargetPlatform defaults to android regardless of
  // the host OS, which makes BannerAdWidget think ads are supported here and
  // try to load one over a platform channel with no test handler — a real
  // hang, not a timer, that no amount of pumping resolves. Overriding to a
  // desktop platform hits the widget's own "ads unsupported" gate, exactly
  // like the real (non-Android/iOS) `flutter run -d windows` this was
  // verified against. Set/reset from inside each test body via
  // addTearDown — not package:test's own setUp/tearDown — because
  // TestWidgetsFlutterBinding checks every debug foundation flag is back to
  // its default as part of finishing that test, before an outer tearDown()
  // callback would even run.
  void useDesktopPlatformForAds() {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
  }

  Widget buildShell({int initialIndex = 0}) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CatalogBloc>(create: (_) => CatalogBloc(buildTestGetCatalogUseCase())),
        BlocProvider<CartBloc>(create: (_) => CartBloc()),
        BlocProvider<OrderBloc>(create: (_) => buildTestOrderBloc()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<AuthBloc>(create: (_) => buildTestAuthBloc()),
      ],
      child: MaterialApp(home: MainShellScreen(initialIndex: initialIndex)),
    );
  }

  testWidgets('shows all 4 tabs, with no owner/admin entry point', (tester) async {
    useDesktopPlatformForAds();
    await tester.pumpWidget(buildShell());
    // Home's FoodCard grid has an intentionally infinite spicy-badge shimmer
    // (flutter_animate's `.repeat(reverse: true)`), so pumpAndSettle() would
    // never return — advance a few bounded frames instead.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    // flutter_animate's entrance animations (the category chips) schedule a
    // short one-shot restart-batching Timer that a plain pump() never fires
    // on its own. NOT pumpAndSettle here — Home's AppBar icon has a genuinely
    // infinite `.animate(onPlay: (c) => c.repeat(reverse: true))` pulse that
    // is on screen regardless of catalog data, so pumpAndSettle can never
    // truly settle and always eventually throws "pumpAndSettle timed out".
    // A couple of fixed pumps advances real time far enough to flush the
    // one-shot timer without waiting for the infinite one to "finish".
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Cart'), findsOneWidget);
    expect(find.text('Orders'), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
    expect(find.textContaining('Owner'), findsNothing);
  });

  testWidgets('tapping Account switches to the Account screen with a theme switch', (tester) async {
    useDesktopPlatformForAds();
    await tester.pumpWidget(buildShell());
    // Home's FoodCard grid has an intentionally infinite spicy-badge shimmer
    // (flutter_animate's `.repeat(reverse: true)`), so pumpAndSettle() would
    // never return — advance a few bounded frames instead.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('Account'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    // Same flutter_animate restart-batching Timer as above, this time from
    // Account screen's own entrance animations. Fixed pumps, not
    // pumpAndSettle, for the same reason noted in the first test — this
    // suite doesn't assume anything about what does or doesn't animate
    // forever, so it never asks the binding to prove a negative.
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Appearance'), findsOneWidget);
    expect(find.byType(SegmentedButton<ThemeMode>), findsOneWidget);
  });
}
