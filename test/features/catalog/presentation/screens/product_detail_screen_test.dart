import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cremen_eatstreet_shop_application/core/di/injection.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/bloc/reviews_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/screens/product_detail_screen.dart';
import '../../../../support/product_fixtures.dart';

void main() {
  setUp(() {
    final reviewsUseCases = buildTestReviewsUseCases();
    getIt.registerFactory<ReviewsBloc>(() => ReviewsBloc(
          getReviews: reviewsUseCases.getReviews,
          getEligibleReviewOrder: reviewsUseCases.getEligibleReviewOrder,
          submitReview: reviewsUseCases.submitReview,
        ));
  });

  tearDown(() => getIt.reset());

  testWidgets('shows product details screen with a back button', (tester) async {
    final product = buildTestProduct(name: 'Demo Bhel');

    await tester.pumpWidget(
      MaterialApp(
        home: ProductDetailScreen(product: product),
      ),
    );
    // Two things need to settle before this test can end cleanly:
    // (1) ReviewsBloc awaits two use cases in sequence (even the fakes are
    //     real Futures), each needing its own pump to drain; and
    // (2) flutter_animate's entrance animations (the category chips etc.)
    //     schedule a short internal restart-batching Timer (~150ms, one-shot)
    //     during initState that a plain pump() never fires, since it only
    //     flushes microtasks/one frame without advancing the fake clock —
    //     leaving it "pending" past teardown unless a pump explicitly moves
    //     time forward past it.
    await tester.pumpAndSettle(
      const Duration(milliseconds: 200),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 5),
    );

    expect(find.text('Demo Bhel'), findsWidgets);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });
}
