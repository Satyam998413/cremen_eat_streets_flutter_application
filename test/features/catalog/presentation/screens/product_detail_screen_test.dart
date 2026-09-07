import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/get_eligible_review_order_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/get_reviews_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/domain/usecases/submit_review_usecase.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/screens/product_detail_screen.dart';
import '../../../../support/product_fixtures.dart';

void main() {
  testWidgets('shows product details screen with a back button', (tester) async {
    final product = buildTestProduct(name: 'Demo Bhel');
    final reviewsUseCases = buildTestReviewsUseCases();

    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<GetReviewsUseCase>.value(value: reviewsUseCases.getReviews),
          RepositoryProvider<GetEligibleReviewOrderUseCase>.value(value: reviewsUseCases.getEligibleReviewOrder),
          RepositoryProvider<SubmitReviewUseCase>.value(value: reviewsUseCases.submitReview),
        ],
        child: MaterialApp(
          home: ProductDetailScreen(product: product),
        ),
      ),
    );

    expect(find.text('Demo Bhel'), findsWidgets);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });
}
