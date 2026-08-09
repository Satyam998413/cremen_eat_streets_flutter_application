import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/category_chip.dart';
import '../../../../core/widgets/food_card.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../bloc/catalog_bloc.dart';
import '../bloc/catalog_event.dart';
import '../bloc/catalog_state.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    context.read<CatalogBloc>().add(CatalogStarted());
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.fastfood, color: Colors.white, size: 20),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(end: 1.1, duration: 1200.ms, curve: Curves.easeInOut),
            const SizedBox(width: 8),
            const Text(
              'Cremen Eat Streets',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar — slides down from top
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: (val) {
                context.read<CatalogBloc>().add(CatalogSearchQueryChanged(val));
              },
              decoration: InputDecoration(
                hintText: 'Search Bhel, Puri, Khaman...',
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.brandPrimary),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context
                              .read<CatalogBloc>()
                              .add(const CatalogSearchQueryChanged(''));
                        },
                      )
                    : null,
                filled: true,
                fillColor: isDark ? AppColors.darkSurface : Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                      const BorderSide(color: AppColors.cardBorder),
                ),
              ),
            ),
          )
              .animate()
              .slideY(begin: -0.4, duration: 400.ms, curve: Curves.easeOutCubic)
              .fadeIn(duration: 400.ms),

          // Category Chips — slide in from left
          BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              final selectedCat =
                  state is CatalogLoaded ? state.selectedCategory : 'all';
              return SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    CategoryChip(
                      label: 'All Items',
                      isSelected: selectedCat == 'all',
                      onTap: () => context
                          .read<CatalogBloc>()
                          .add(const CatalogCategorySelected('all')),
                    ).animate(delay: 50.ms).slideX(
                        begin: -0.5,
                        duration: 350.ms,
                        curve: Curves.easeOutCubic).fadeIn(),
                    CategoryChip(
                      label: '☀️ Morning Specials',
                      isSelected: selectedCat == 'morning_special',
                      onTap: () => context.read<CatalogBloc>().add(
                          const CatalogCategorySelected('morning_special')),
                    ).animate(delay: 120.ms).slideX(
                        begin: -0.5,
                        duration: 350.ms,
                        curve: Curves.easeOutCubic).fadeIn(),
                    CategoryChip(
                      label: '🔥 Bhel Specials',
                      isSelected: selectedCat == 'bhel',
                      onTap: () => context
                          .read<CatalogBloc>()
                          .add(const CatalogCategorySelected('bhel')),
                    ).animate(delay: 190.ms).slideX(
                        begin: -0.5,
                        duration: 350.ms,
                        curve: Curves.easeOutCubic).fadeIn(),
                    CategoryChip(
                      label: '🥟 Puris & Chaat',
                      isSelected: selectedCat == 'puri',
                      onTap: () => context
                          .read<CatalogBloc>()
                          .add(const CatalogCategorySelected('puri')),
                    ).animate(delay: 260.ms).slideX(
                        begin: -0.5,
                        duration: 350.ms,
                        curve: Curves.easeOutCubic).fadeIn(),
                  ],
                ),
              );
            },
          ),

          // Food Catalog Grid — staggered card animations
          Expanded(
            child: BlocBuilder<CatalogBloc, CatalogState>(
              builder: (context, state) {
                if (state is CatalogLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CatalogLoaded) {
                  final products = state.filteredProducts;
                  if (products.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search_off,
                              size: 64, color: AppColors.brandPrimary),
                          const SizedBox(height: 12),
                          const Text('No street food items match your search.',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      )
                          .animate()
                          .fadeIn(duration: 400.ms)
                          .scale(begin: const Offset(0.8, 0.8)),
                    );
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
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
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(product: product),
                            ),
                          );
                        },
                        onAddTap: () {
                          final item = CartItem(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            product: product,
                            quantity: 1,
                          );
                          context
                              .read<CartBloc>()
                              .add(CartItemAdded(item));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: Colors.white, size: 18),
                                  const SizedBox(width: 8),
                                  Text('${product.name} added to cart!'),
                                ],
                              ),
                              backgroundColor: AppColors.successGreen,
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          );
                        },
                      )
                          .animate(delay: Duration(milliseconds: 60 * index))
                          .fadeIn(duration: 400.ms)
                          .slideY(
                            begin: 0.2,
                            duration: 400.ms,
                            curve: Curves.easeOutCubic,
                          );
                    },
                      );
                    },
                  );
                }
                return const Center(child: Text('Failed to load menu.'));
              },
            ),
          ),
        ],
      ),

      // Sticky Bottom Cart Bar — slides up with animation
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          if (cartState.items.isEmpty) return const SizedBox.shrink();

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: AppColors.brandGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.brandPrimary.withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${cartState.itemCount} ${cartState.itemCount == 1 ? 'ITEM' : 'ITEMS'} ADDED',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '₹${cartState.totalAmount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.brandPrimary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => context.push('/cart'),
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: const Text(
                      'View Cart',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .shimmer(
                        duration: 2000.ms,
                        color: AppColors.brandSecondary.withValues(alpha: 0.3),
                      ),
                ],
              ),
            ),
          )
              .animate()
              .slideY(begin: 1.0, duration: 350.ms, curve: Curves.easeOutCubic)
              .fadeIn(duration: 300.ms);
        },
      ),
    );
  }
}
