import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/entities/product.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/screens/product_detail_screen.dart';

void main() {
  testWidgets('shows product details screen with a back button', (tester) async {
    final product = Product(
      id: 'demo',
      name: 'Demo Bhel',
      description: 'A tasty demo item',
      price: 40,
      imageUrl: 'assets/images/cremen_logo.jpg',
      category: 'bhel',
      isSpicy: true,
      isMorningSpecial: false,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: ProductDetailScreen(product: product),
      ),
    );

    expect(find.text('Demo Bhel'), findsWidgets);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });
}
