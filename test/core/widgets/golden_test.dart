import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cremen_eatstreet_shop_application/core/theme/app_colors.dart';
import 'package:cremen_eatstreet_shop_application/core/widgets/app_button.dart';
import 'package:cremen_eatstreet_shop_application/core/widgets/food_card.dart';
import 'package:cremen_eatstreet_shop_application/core/widgets/quantity_selector.dart';
import '../../support/product_fixtures.dart';

/// Deliberately not `AppTheme.lightTheme` — its `textTheme` is built from
/// `GoogleFonts.outfitTextTheme()`, and any attempt to actually load a
/// Google Font throws inside `flutter test` (there's no real network, and
/// the package rethrows the failure regardless of
/// `GoogleFonts.config.allowRuntimeFetching`). Same colors/shapes as the
/// real theme, just Flutter's built-in font instead — the goldens below are
/// locking in layout/color regressions, not font rendering.
Widget _wrap(Widget child) {
  return MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brandPrimary,
        brightness: Brightness.light,
        primary: AppColors.brandPrimary,
        secondary: AppColors.brandSecondary,
        surface: AppColors.lightSurface,
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('AppButton', () {
    testWidgets('filled', (tester) async {
      await tester.pumpWidget(_wrap(
        SizedBox(width: 220, child: AppButton(label: 'Pay Now', onPressed: () {})),
      ));
      await tester.pumpAndSettle();
      await expectLater(find.byType(AppButton), matchesGoldenFile('goldens/app_button_filled.png'));
    });

    testWidgets('outlined', (tester) async {
      await tester.pumpWidget(_wrap(
        SizedBox(width: 220, child: AppButton(label: 'Cancel', isOutlined: true, onPressed: () {})),
      ));
      await tester.pumpAndSettle();
      await expectLater(find.byType(AppButton), matchesGoldenFile('goldens/app_button_outlined.png'));
    });

    testWidgets('loading', (tester) async {
      await tester.pumpWidget(_wrap(
        SizedBox(width: 220, child: AppButton(label: 'Pay Now', isLoading: true, onPressed: () {})),
      ));
      await tester.pump();
      await expectLater(find.byType(AppButton), matchesGoldenFile('goldens/app_button_loading.png'));
    });
  });

  testWidgets('QuantitySelector renders a given quantity', (tester) async {
    await tester.pumpWidget(_wrap(
      QuantitySelector(quantity: 3, onIncrement: () {}, onDecrement: () {}),
    ));
    await tester.pumpAndSettle();
    await expectLater(find.byType(QuantitySelector), matchesGoldenFile('goldens/quantity_selector.png'));
  });

  group('FoodCard', () {
    // isSpicy: false is deliberate — the spicy badge's
    // `.animate(onPlay: (c) => c.repeat(reverse: true))` schedules a Timer
    // that never completes, which flutter_test's own end-of-test teardown
    // flags as an error (confirmed independently while regression-testing
    // the layout fix this card required). A non-spicy fixture never builds
    // that subtree at all, so this stays timer-free and safe to golden-test.
    // Runs after 'veg product' below, in declared order — the two share the
    // same underlying asset image, and its decoded-codec cache only warms up
    // reliably by the second request in this harness (precacheImage() was
    // tried to make each test self-sufficient here, but it deadlocks under
    // flutter_test rather than completing). Not a real flake: Dart's test
    // runner always executes a file's tests in declaration order, so which
    // of these two shows the fully-decoded image vs. a blank first-paint is
    // itself deterministic — just an artifact of this pair's ordering,
    // harmless to what these goldens actually protect (the card's
    // Expanded/flex layout proportions and the veg/non-veg badge).
    testWidgets('veg product', (tester) async {
      final product = buildTestProduct(name: 'Veg Bhel', isSpicy: false, isVeg: true);
      await tester.pumpWidget(_wrap(
        SizedBox(
          width: 200,
          height: 260,
          child: FoodCard(product: product, onTap: () {}, onAddTap: () {}),
        ),
      ));
      await tester.pumpAndSettle();
      await expectLater(find.byType(FoodCard), matchesGoldenFile('goldens/food_card_veg.png'));
    });

    testWidgets('non-veg product', (tester) async {
      final product = buildTestProduct(name: 'Chicken Roll', isSpicy: false, isVeg: false);
      await tester.pumpWidget(_wrap(
        SizedBox(
          width: 200,
          height: 260,
          child: FoodCard(product: product, onTap: () {}, onAddTap: () {}),
        ),
      ));
      await tester.pumpAndSettle();
      await expectLater(find.byType(FoodCard), matchesGoldenFile('goldens/food_card_non_veg.png'));
    });
  });
}
