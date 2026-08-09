import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/quantity_selector.dart';
import '../../../../core/widgets/responsive_product_image.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../domain/entities/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  int _selectedNavIndex = 0;
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.product.name),
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
                  imageUrl: widget.product.imageUrl,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(20),
                  fallbackColor: AppColors.brandPrimary.withValues(alpha: 0.12),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: widget.product.isMorningSpecial
                          ? AppColors.morningGold
                          : AppColors.brandPrimary,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      widget.product.isMorningSpecial ? 'Morning Special' : 'Popular',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '₹${widget.product.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.brandPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.product.description,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Select Spice Level 🌶️', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['Mild', 'Medium', 'Spicy'].map((level) {
                  final isSelected = _spiceLevel == level;
                  return ChoiceChip(
                    label: Text(level),
                    selected: isSelected,
                    selectedColor: AppColors.brandPrimary,
                    onSelected: (value) {
                      if (value) {
                        setState(() => _spiceLevel = level);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Extra Fresh Cheese (+₹15)'),
                subtitle: const Text('Rich, creamy paneer topping', style: TextStyle(fontSize: 12)),
                value: _hasExtraCheese,
                activeColor: AppColors.brandPrimary,
                onChanged: (value) => setState(() => _hasExtraCheese = value ?? false),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _instructionsController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Special Instructions (e.g. No onion)',
                  prefixIcon: const Icon(Icons.edit_note, color: AppColors.brandPrimary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
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
                      label: 'Add to Cart • ₹${_totalPrice.toStringAsFixed(0)}',
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
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.check_circle, color: Colors.white, size: 18),
                                const SizedBox(width: 8),
                                Text('${widget.product.name} added!'),
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedNavIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedNavIndex = index);
          if (index == 0) {
            context.pop();
          } else {
            context.push('/cart');
          }
        },
      ),
    );
  }
}
