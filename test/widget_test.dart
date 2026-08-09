import 'package:flutter_test/flutter_test.dart';
import 'package:cremen_eatstreet_shop_application/main.dart';

void main() {
  testWidgets('App renders onboarding title correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const CremenEatStreetApp());
    await tester.pumpAndSettle();

    expect(find.text('Cremen Eat Streets'), findsOneWidget);
    expect(find.text('Explore Menu & Order'), findsOneWidget);
  });
}
