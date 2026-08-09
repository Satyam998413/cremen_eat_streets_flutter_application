import 'package:cremen_eatstreet_shop_application/core/widgets/main_shell_screen.dart';
import 'package:cremen_eatstreet_shop_application/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:cremen_eatstreet_shop_application/features/orders/presentation/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the bottom nav items and opens owner PIN flow', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<CatalogBloc>(create: (_) => CatalogBloc()),
          BlocProvider<CartBloc>(create: (_) => CartBloc()),
          BlocProvider<OrderBloc>(create: (_) => OrderBloc()),
        ],
        child: const MaterialApp(home: MainShellScreen(initialIndex: 0)),
      ),
    );

    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('Orders'), findsOneWidget);
    expect(find.text('Owner'), findsOneWidget);

    await tester.tap(find.text('Owner'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    expect(find.text('Owner Access'), findsOneWidget);

    await tester.tapAt(const Offset(20, 20));
    await tester.pump();
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
