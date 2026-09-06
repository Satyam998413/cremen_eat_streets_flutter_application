import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/screens/product_detail_screen.dart';
import '../../../../support/product_fixtures.dart';

void main() {
  testWidgets('shows product details screen with a back button', (tester) async {
    final product = buildTestProduct(name: 'Demo Bhel');

    await tester.pumpWidget(
      MaterialApp(
        home: ProductDetailScreen(product: product),
      ),
    );

    expect(find.text('Demo Bhel'), findsWidgets);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });
}
