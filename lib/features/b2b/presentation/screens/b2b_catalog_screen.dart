import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/pricing/wholesale_fee_calculator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/error_state_view.dart';
import '../../../../core/widgets/food_card.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/wholesale_delivery_banner.dart';
import '../../../auth/domain/entities/account_role.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../../../catalog/presentation/bloc/catalog_bloc.dart';
import '../../../catalog/presentation/bloc/catalog_event.dart';
import '../../../catalog/presentation/bloc/catalog_state.dart';
import '../../../catalog/presentation/screens/product_detail_screen.dart';
import '../bloc/sales_wholesaler_cubit.dart';
import 'wholesaler_picker_sheet.dart';

/// The salesman/wholesaler equivalent of HomeScreen — same catalog data,
/// priced at the wholesale tier (via FoodCard's own tier-aware pricing,
/// AuthBloc-driven), plus the B2B-specific delivery-threshold banner and
/// (salesman only) "ordering for" wholesaler picker.
class B2bCatalogScreen extends StatefulWidget {
  const B2bCatalogScreen({super.key});

  @override
  State<B2bCatalogScreen> createState() => _B2bCatalogScreenState();
}

class _B2bCatalogScreenState extends State<B2bCatalogScreen> {
  final _salesWholesalerCubit = getIt<SalesWholesalerCubit>();

  @override
  void initState() {
    super.initState();
    context.read<CatalogBloc>().add(const CatalogEvent.requested());
    final authState = context.read<AuthBloc>().state;
    if (authState case Authenticated(role: AccountRole.salesman, profile: final profile)) {
      _salesWholesalerCubit.loadFor(profile.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;
    final role = authState is Authenticated ? authState.role : AccountRole.customer;
    final isSalesman = role == AccountRole.salesman;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wholesale Ordering'),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) => Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () => context.push('/cart'),
                ),
                if (cartState.itemCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(color: AppColors.spicyRed, shape: BoxShape.circle),
                      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '${cartState.itemCount > 9 ? '9+' : cartState.itemCount}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isSalesman) ...[
                  WholesalerBanner(cubit: _salesWholesalerCubit),
                  const SizedBox(height: 8),
                ],
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, cartState) => WholesaleDeliveryBanner(
                    packetCount: WholesaleFeeCalculator.calcPacketCount(cartState.items.map((i) => i.quantity)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CatalogBloc, CatalogState>(
              builder: (context, state) {
                if (state is CatalogLoading) {
                  return const ShimmerGridSkeleton();
                } else if (state is CatalogFailure) {
                  return ErrorStateView(
                    message: 'Could not load the catalog: ${state.message}',
                    icon: Icons.wifi_off_rounded,
                    onAction: () => context.read<CatalogBloc>().add(const CatalogEvent.requested()),
                    actionLabel: 'Retry',
                  );
                } else if (state is CatalogLoaded) {
                  final products = state.filteredProducts;
                  if (products.isEmpty) {
                    return const EmptyStateView(icon: Icons.inventory_2_outlined, title: 'No products available.');
                  }
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth >= 900
                          ? 4
                          : constraints.maxWidth >= 600
                              ? 3
                              : 2;
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return FoodCard(
                            product: product,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
                              );
                            },
                            onAddTap: () {
                              // Captured from the enclosing build(), not
                              // re-resolved here — `context.watch` (which
                              // watchPricingTier uses) may only be called
                              // during build, never from an onPressed-style
                              // callback like this one.
                              final item = CartItem(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                product: product,
                                quantity: 1,
                                pricingTier: role.pricingTier,
                              );
                              context.read<CartBloc>().add(CartItemAdded(item));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${product.name} added to cart!'),
                                  backgroundColor: AppColors.successGreen,
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              );
                            },
                          ).animate(delay: Duration(milliseconds: 40 * index)).fadeIn(duration: 350.ms);
                        },
                      );
                    },
                  );
                }
                return const Center(child: Text('Failed to load catalog.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
