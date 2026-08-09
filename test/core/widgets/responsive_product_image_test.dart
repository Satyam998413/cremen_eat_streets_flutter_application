import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cremen_eatstreet_shop_application/core/widgets/responsive_product_image.dart';

void main() {
  testWidgets('renders asset fallback when no remote image is available', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ResponsiveProductImage(
            imageUrl: '',
            placeholderAsset: 'assets/images/cremen_logo.jpg',
          ),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
    expect(find.byIcon(Icons.fastfood), findsNothing);
  });
}
