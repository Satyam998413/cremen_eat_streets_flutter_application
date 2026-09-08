import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:cremen_eatstreet_shop_application/core/di/injection.dart';
import 'package:cremen_eatstreet_shop_application/core/theme/theme_cubit.dart';
import 'package:cremen_eatstreet_shop_application/main.dart';
import 'support/auth_test_support.dart';
import 'support/hive_test_utils.dart';

void main() {
  setUpAll(() async {
    await initIsolatedHive();
    await Hive.openBox(ThemeCubit.boxName);
    await initTestSupabase();
    // CremenEatStreetApp resolves every bloc via getIt now — same real
    // Supabase client initTestSupabase() just set up, so this wires exactly
    // what production does, just against the isolated test Hive boxes above.
    configureDependencies();
  });

  testWidgets('App goes straight to Login after Splash', (WidgetTester tester) async {
    await tester.pumpWidget(const CremenEatStreetApp());
    // Splash runs infinitely-repeating particle/ripple animations, so
    // pumpAndSettle() would never return — advance past Splash's fixed
    // 3.8s auto-navigate timer with bounded pumps instead.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 4000));
    await tester.pump(const Duration(milliseconds: 300));
    // By now Splash (and its infinite particle/ripple animation) is
    // unmounted and Login is showing. Login's own entrance animations
    // schedule a short one-shot flutter_animate restart-batching Timer that
    // a plain pump() never fires (it needs the fake clock to actually move
    // forward) — a short, bounded pumpAndSettle flushes it without risking
    // the hang a default/unbounded one would if anything were still
    // genuinely repeating.
    await tester.pumpAndSettle(
      const Duration(milliseconds: 200),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 5),
    );

    expect(find.text('Log In'), findsWidgets);
    expect(find.text('Continue as Guest'), findsOneWidget);
  });
}
