import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:cremen_eatstreet_shop_application/core/theme/theme_cubit.dart';
import 'package:cremen_eatstreet_shop_application/main.dart';
import 'support/auth_test_support.dart';
import 'support/hive_test_utils.dart';

void main() {
  setUpAll(() async {
    await initIsolatedHive();
    await Hive.openBox(ThemeCubit.boxName);
    await initTestSupabase();
  });

  testWidgets('App renders onboarding title correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const CremenEatStreetApp());
    // Splash runs infinitely-repeating particle/ripple animations, so
    // pumpAndSettle() would never return — advance past Splash's fixed
    // 3.8s auto-navigate timer with bounded pumps instead.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 4000));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Cremen Eat Streets'), findsOneWidget);
    expect(find.text('Explore Menu & Order'), findsOneWidget);
  });
}
