import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../orders/presentation/screens/order_history_screen.dart';
import '../../../profile/presentation/screens/account_screen.dart';
import 'b2b_catalog_screen.dart';

/// The salesman/wholesaler "home" — this app's B2B accounts never see
/// [MainShellScreen] (the retail customer shell): its catalog tab, Home
/// wording, and the food-forward branding around it are retail-specific.
/// Cart/Orders/Account are generic enough to reuse as-is; only the catalog
/// tab is swapped for [B2bCatalogScreen].
class B2bShellScreen extends StatefulWidget {
  const B2bShellScreen({super.key});

  @override
  State<B2bShellScreen> createState() => _B2bShellScreenState();
}

class _B2bShellScreenState extends State<B2bShellScreen> {
  int _selectedIndex = 0;

  static const _pages = [
    B2bCatalogScreen(key: ValueKey('b2b-catalog')),
    CartScreen(key: ValueKey('b2b-cart')),
    OrderHistoryScreen(key: ValueKey('b2b-orders')),
    AccountScreen(key: ValueKey('b2b-account')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          return NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) => setState(() => _selectedIndex = index),
            indicatorColor: AppColors.brandPrimary.withValues(alpha: 0.16),
            destinations: [
              const NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'Catalog'),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: cartState.itemCount > 0,
                  label: Text('${cartState.itemCount}'),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                label: 'Cart',
              ),
              const NavigationDestination(icon: Icon(Icons.receipt_long_rounded), label: 'Orders'),
              const NavigationDestination(icon: Icon(Icons.person_outline_rounded), label: 'Account'),
            ],
          );
        },
      ),
    );
  }
}
