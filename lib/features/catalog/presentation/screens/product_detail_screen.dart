import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/pricing/pricing_context.dart';
import '../../../../core/pricing/pricing_resolver.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../../../core/widgets/quantity_selector.dart';
import '../../../../core/widgets/responsive_product_image.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../bloc/reviews_bloc.dart';
import '../bloc/reviews_event.dart';
import '../bloc/reviews_state.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  String? _selectedVariantLabel;

  late final ReviewsBloc _reviewsBloc;
  final TextEditingController _reviewCommentController = TextEditingController();
  int _reviewRating = 5;

  @override
  void initState() {
    super.initState();
    if (widget.product.hasVariants) {
      _selectedVariantLabel = widget.product.variants.first.label;
    }
    _reviewsBloc = getIt<ReviewsBloc>()..add(ReviewsEvent.loadRequested(widget.product.id));
  }

  @override
  void dispose() {
    _reviewsBloc.close();
    _reviewCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final product = widget.product;
    final tier = watchPricingTier(context);
    final unitPrice =
        PricingResolver.resolveUnitPrice(product, variantLabel: _selectedVariantLabel, tier: tier) ??
            product.basePrice;
    final compareAtPrice = PricingResolver.resolveCompareAtPrice(product, variantLabel: _selectedVariantLabel);

    return BlocProvider<ReviewsBloc>.value(
      value: _reviewsBloc,
      child: _buildScaffold(context, isDark, product, tier, unitPrice, compareAtPrice),
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    bool isDark,
    Product product,
    PricingTier tier,
    double unitPrice,
    double? compareAtPrice,
  ) {
    final totalPrice = unitPrice * _quantity;
    final discountPercent = PricingResolver.discountPercent(unitPrice, compareAtPrice);
    final showCompareAt = compareAtPrice != null && compareAtPrice > unitPrice;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(product.name),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ResponsiveProductImage(
                  imageUrl: product.primaryImageUrl,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(20),
                  fallbackColor: AppColors.brandPrimary.withValues(alpha: 0.12),
                  heroTag: 'product-image-${product.id}',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product.name,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (product.isSpicy ?? false)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.spicyRed,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        '🔥 Spicy',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                ],
              ),
              if (product.subtitle != null && product.subtitle!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  product.subtitle!,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '₹${unitPrice.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.brandPrimary),
                  ),
                  if (showCompareAt) ...[
                    const SizedBox(width: 8),
                    Text(
                      '₹${compareAtPrice.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.lineThrough,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                  if (discountPercent != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.successGreen,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '$discountPercent% OFF',
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Text(
                product.description,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ),
              if (product.hasVariants) ...[
                const SizedBox(height: 20),
                const Text('Choose an option', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: product.variants.map((variant) {
                    final isSelected = _selectedVariantLabel == variant.label;
                    final variantPrice =
                        PricingResolver.resolveUnitPrice(product, variantLabel: variant.label, tier: tier) ??
                            variant.price;
                    return ChoiceChip(
                      label: Text('${variant.label} • ₹${variantPrice.toStringAsFixed(0)}'),
                      selected: isSelected,
                      selectedColor: AppColors.brandPrimary,
                      onSelected: (value) {
                        if (value) setState(() => _selectedVariantLabel = variant.label);
                      },
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  QuantitySelector(
                    quantity: _quantity,
                    onIncrement: () => setState(() => _quantity++),
                    onDecrement: () {
                      if (_quantity > 1) setState(() => _quantity--);
                    },
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      label: 'Add to Cart • ₹${totalPrice.toStringAsFixed(0)}',
                      onPressed: () {
                        final item = CartItem(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          product: product,
                          quantity: _quantity,
                          variantLabel: _selectedVariantLabel,
                          pricingTier: tier,
                        );
                        context.read<CartBloc>().add(CartItemAdded(item));
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.check_circle, color: Colors.white, size: 18),
                                const SizedBox(width: 8),
                                Text('${product.name} added!'),
                              ],
                            ),
                            backgroundColor: AppColors.successGreen,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ).animate(delay: 150.ms).fadeIn(duration: 350.ms).slideY(begin: 0.15, curve: Curves.easeOutCubic),
              const SizedBox(height: 28),
              const Divider(),
              const SizedBox(height: 12),
              _buildReviewsSection(context, isDark)
                  .animate(delay: 220.ms)
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.1, curve: Curves.easeOutCubic),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsSection(BuildContext context, bool isDark) {
    return BlocConsumer<ReviewsBloc, ReviewsState>(
      listener: (context, state) {
        if (state is ReviewsLoaded && state.submitSucceeded) {
          _reviewCommentController.clear();
          setState(() => _reviewRating = 5);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Review submitted — thank you!')),
          );
        }
        if (state is ReviewsLoaded && state.submitError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.submitError!)),
          );
        }
      },
      builder: (context, state) {
        return switch (state) {
          ReviewsLoading() => const ShimmerListSkeleton(itemCount: 3, rowHeight: 56),
          ReviewsFailure() => const SizedBox.shrink(),
          ReviewsLoaded(:final reviews, :final canReview, :final isSubmitting) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reviews (${reviews.length})',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(height: 12),
                if (reviews.isEmpty)
                  Text(
                    'No reviews yet.',
                    style: TextStyle(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  )
                else
                  ...reviews.map((review) => _ReviewTile(review: review, isDark: isDark)),
                if (canReview) ...[
                  const SizedBox(height: 20),
                  const Text('Leave a Review', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) {
                      final starValue = index + 1;
                      return IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          starValue <= _reviewRating ? Icons.star : Icons.star_border,
                          color: AppColors.brandPrimary,
                        ),
                        onPressed: () => setState(() => _reviewRating = starValue),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _reviewCommentController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Share your experience (optional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    label: 'Submit Review',
                    isLoading: isSubmitting,
                    onPressed: () {
                      final authState = context.read<AuthBloc>().state;
                      final reviewerName =
                          authState is Authenticated ? authState.profile.fullName : 'Guest';
                      context.read<ReviewsBloc>().add(ReviewsEvent.submitRequested(
                            reviewerName: reviewerName,
                            rating: _reviewRating,
                            comment: _reviewCommentController.text.trim().isEmpty
                                ? null
                                : _reviewCommentController.text.trim(),
                          ));
                    },
                  ),
                ],
              ],
            ),
        };
      },
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review, required this.isDark});

  final Review review;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(review.reviewerName, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(width: 8),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < review.rating ? Icons.star : Icons.star_border,
                    size: 14,
                    color: AppColors.brandPrimary,
                  );
                }),
              ),
            ],
          ),
          if (review.comment != null && review.comment!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              review.comment!,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
