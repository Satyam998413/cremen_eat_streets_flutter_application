import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/quantity_selector.dart';
import '../../../../core/widgets/responsive_product_image.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../domain/entities/product.dart';

class ProductDetailModal extends StatefulWidget {
  final Product product;

  const ProductDetailModal({super.key, required this.product});

  @override
  State<ProductDetailModal> createState() => _ProductDetailModalState();
}

class _ProductDetailModalState extends State<ProductDetailModal> {
  int _quantity = 1;
  String _spiceLevel = 'Medium';
  bool _hasExtraCheese = false;
  final TextEditingController _instructionsController = TextEditingController();

  double get _totalPrice =>
      (widget.product.price + (_hasExtraCheese ? 15 : 0)) * _quantity;

  @override
  void dispose() {
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated Handle Bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            )
                .animate()
                .scaleX(begin: 0.3, duration: 500.ms, curve: Curves.elasticOut),
            const SizedBox(height: 16),

            // Header Image & Title — fade + slide in
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'product_${widget.product.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: ResponsiveProductImage(
                      imageUrl: widget.product.imageUrl,
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(14),
                      fallbackColor: AppColors.brandPrimary.withValues(alpha: 0.15),
                      fallbackIcon: Icons.fastfood,
                    ),
                  ),
                )
                    .animate()
                    .scale(
                      begin: const Offset(0.7, 0.7),
                      duration: 450.ms,
                      curve: Curves.easeOutBack,
                    )
                    .fadeIn(duration: 300.ms),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                          .animate(delay: 100.ms)
                          .fadeIn(duration: 400.ms)
                          .slideX(begin: 0.2),
                      const SizedBox(height: 6),
                      Text(
                        '₹${widget.product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.brandPrimary,
                        ),
                      )
                          .animate(delay: 150.ms)
                          .fadeIn(duration: 400.ms)
                          .slideX(begin: 0.2),
                      if (widget.product.isSpicy)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.local_fire_department,
                                  size: 14, color: AppColors.spicyRed),
                              const SizedBox(width: 4),
                              Text(
                                'Spicy',
                                style: TextStyle(
                                  color: AppColors.spicyRed,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.product.description,
              style: TextStyle(
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                height: 1.5,
              ),
            )
                .animate(delay: 200.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.15),
            const Divider(height: 28),

            // Spice Level Selection — slide in options
            const Text(
              'Select Spice Level 🌶️',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ).animate(delay: 250.ms).fadeIn(duration: 300.ms),
            const SizedBox(height: 8),
            Row(
              children: ['Mild', 'Medium', 'Spicy'].asMap().entries.map((entry) {
                final i = entry.key;
                final level = entry.value;
                final isSelected = _spiceLevel == level;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(level),
                    selected: isSelected,
                    selectedColor: AppColors.brandPrimary,
                    onSelected: (val) {
                      if (val) setState(() => _spiceLevel = level);
                    },
                  )
                      .animate(delay: Duration(milliseconds: 280 + i * 80))
                      .fadeIn(duration: 300.ms)
                      .slideY(begin: 0.3, curve: Curves.easeOutCubic),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Addon Options
            const Text(
              'Addons ✨',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ).animate(delay: 350.ms).fadeIn(duration: 300.ms),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Extra Fresh Cheese (+₹15)'),
              subtitle: const Text('Rich, creamy paneer topping',
                  style: TextStyle(fontSize: 12)),
              value: _hasExtraCheese,
              activeColor: AppColors.brandPrimary,
              onChanged: (val) =>
                  setState(() => _hasExtraCheese = val ?? false),
            ).animate(delay: 380.ms).fadeIn(duration: 300.ms).slideX(begin: -0.1),

            // Special Instructions
            TextField(
              controller: _instructionsController,
              decoration: InputDecoration(
                labelText: 'Special Instructions (e.g. No onion)',
                prefixIcon: const Icon(Icons.edit_note,
                    color: AppColors.brandPrimary),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ).animate(delay: 420.ms).fadeIn(duration: 300.ms),
            const SizedBox(height: 20),

            // Quantity & Add to Cart — slide up
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
                    label:
                        'Add to Cart • ₹${_totalPrice.toStringAsFixed(0)}',
                    onPressed: () {
                      final item = CartItem(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        product: widget.product,
                        quantity: _quantity,
                        spiceLevel: _spiceLevel,
                        hasExtraCheese: _hasExtraCheese,
                        specialInstructions: _instructionsController.text,
                      );
                      context.read<CartBloc>().add(CartItemAdded(item));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(Icons.check_circle,
                                  color: Colors.white, size: 18),
                              const SizedBox(width: 8),
                              Text('${widget.product.name} added!'),
                            ],
                          ),
                          backgroundColor: AppColors.successGreen,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
                .animate(delay: 450.ms)
                .slideY(begin: 0.4, duration: 400.ms, curve: Curves.easeOutCubic)
                .fadeIn(duration: 350.ms),
          ],
        ),
      ),
    );
  }
}
