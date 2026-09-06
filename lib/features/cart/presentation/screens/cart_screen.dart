import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/quantity_selector.dart';
import '../../../../core/widgets/responsive_product_image.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

/// Review-only — fulfillment type, customer details, and Pay Now live on the
/// Checkout screen (matches the website's own /cart vs /checkout split; see
/// plan/user-app-production-rebuild.md Step 2a).
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear Cart',
            onPressed: () => context.read<CartBloc>().add(CartCleared()),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 80, color: AppColors.brandPrimary),
                  const SizedBox(height: 16),
                  const Text('Your cart is empty', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Add some delicious Surat street food!'),
                  const SizedBox(height: 24),
                  AppButton(label: 'Browse Menu', onPressed: () => context.go('/')),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ResponsiveProductImage(
                              imageUrl: item.product.primaryImageUrl,
                              width: 65,
                              height: 65,
                              fit: BoxFit.cover,
                              borderRadius: BorderRadius.circular(12),
                              fallbackColor: AppColors.brandPrimary.withValues(alpha: 0.12),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                if (item.variantLabel != null)
                                  Text(
                                    item.variantLabel!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                    ),
                                  ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹${item.totalPrice.toStringAsFixed(0)}',
                                  style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.brandPrimary),
                                ),
                              ],
                            ),
                          ),
                          QuantitySelector(
                            quantity: item.quantity,
                            onIncrement: () => context.read<CartBloc>().add(CartItemQuantityChanged(item.id, 1)),
                            onDecrement: () => context.read<CartBloc>().add(CartItemQuantityChanged(item.id, -1)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SafeArea(
                minimum: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(
                          '₹${state.totalAmount.toStringAsFixed(0)}',
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppColors.brandPrimary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    AppButton(
                      label: 'Proceed to Checkout',
                      icon: Icons.arrow_forward,
                      onPressed: () => context.push('/checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
