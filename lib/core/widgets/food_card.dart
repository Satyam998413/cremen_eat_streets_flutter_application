import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../features/catalog/domain/entities/product.dart';
import '../theme/app_colors.dart';
import 'responsive_product_image.dart';

class FoodCard extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onAddTap;

  const FoodCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onAddTap,
  });

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _tapController;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.06,
    );
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _tapController.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _tapController.reverse();
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _tapController.reverse();
      },
      child: AnimatedBuilder(
        animation: _tapController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 - _tapController.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isPressed
                  ? AppColors.brandPrimary
                  : widget.product.isMorningSpecial
                      ? AppColors.morningGold
                      : AppColors.cardBorder,
              width: _isPressed ? 2 : widget.product.isMorningSpecial ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _isPressed
                    ? AppColors.brandPrimary.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.05),
                blurRadius: _isPressed ? 16 : 10,
                spreadRadius: _isPressed ? 2 : 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Stack with Badges
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(19)),
                    child: ResponsiveProductImage(
                      imageUrl: widget.product.imageUrl,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(19),
                      ),
                      fallbackColor: AppColors.brandPrimary.withValues(alpha: 0.12),
                    ),
                  ),
                  if (widget.product.isSpicy)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.spicyRed,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.local_fire_department,
                                size: 12, color: Colors.white),
                            SizedBox(width: 2),
                            Text(
                              'Spicy',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .scaleXY(
                            end: 1.08,
                            duration: 1000.ms,
                            curve: Curves.easeInOut,
                          ),
                    ),
                  if (widget.product.isMorningSpecial)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.morningGold,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          '☀️ Special',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .shimmer(
                            duration: 1800.ms,
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                    ),
                ],
              ),
              // Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.product.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹${widget.product.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.brandPrimary,
                            ),
                          ),
                          _AddButton(onTap: widget.onAddTap),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Animated ADD button with bounce on press
class _AddButton extends StatefulWidget {
  final VoidCallback onTap;
  const _AddButton({required this.onTap});

  @override
  State<_AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<_AddButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) async {
        await _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, child) => Transform.scale(
          scale: 1.0 - _ctrl.value * 0.15,
          child: child,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.brandPrimary.withValues(alpha: 0.4),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Text(
            '+ ADD',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
