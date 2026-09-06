import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/cart/presentation/bloc/cart_state.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/catalog/presentation/screens/home_screen.dart';
import '../../features/orders/presentation/screens/order_history_screen.dart';
import '../../features/profile/presentation/screens/account_screen.dart';
import '../theme/app_colors.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key, required this.initialIndex});

  final int initialIndex;

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  late int _selectedIndex;
  bool _isBarVisible = true;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.clamp(0, 3);
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
  }

  // Smart bottom bar: slides out of the way while the user scrolls down through
  // a long menu/order list, and reappears the moment they scroll back up.
  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      final scrollingDown = notification.direction == ScrollDirection.reverse;
      final shouldShow = !scrollingDown;
      if (shouldShow != _isBarVisible) {
        setState(() => _isBarVisible = shouldShow);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: _buildPage(_selectedIndex),
        ),
      ),
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        offset: _isBarVisible ? Offset.zero : const Offset(0, 1.4),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.cardBorder.withValues(alpha: 0.4)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.brandPrimary.withValues(alpha: 0.16),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  _NavItem(
                    icon: Icons.restaurant_menu_rounded,
                    label: 'Home',
                    selected: _selectedIndex == 0,
                    onTap: () => _onItemTapped(0),
                  ),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, cartState) => _NavItem(
                      icon: Icons.shopping_cart_outlined,
                      label: 'Cart',
                      selected: _selectedIndex == 1,
                      onTap: () => _onItemTapped(1),
                      badgeCount: cartState.itemCount,
                    ),
                  ),
                  _NavItem(
                    icon: Icons.receipt_long_rounded,
                    label: 'Orders',
                    selected: _selectedIndex == 2,
                    onTap: () => _onItemTapped(2),
                  ),
                  _NavItem(
                    icon: Icons.person_outline_rounded,
                    label: 'Account',
                    selected: _selectedIndex == 3,
                    onTap: () => _onItemTapped(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 1:
        return const CartScreen(key: ValueKey('cart'));
      case 2:
        return const OrderHistoryScreen(key: ValueKey('orders'));
      case 3:
        return const AccountScreen(key: ValueKey('account'));
      case 0:
      default:
        return const HomeScreen(key: ValueKey('home'));
    }
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.badgeCount = 0,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.brandPrimary : AppColors.textSecondaryLight;
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        label: badgeCount > 0 ? '$label, $badgeCount items' : label,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: selected ? AppColors.brandPrimary.withValues(alpha: 0.12) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedScale(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      scale: selected ? 1.08 : 1.0,
                      child: Icon(icon, color: color, size: 22),
                    ),
                    if (badgeCount > 0)
                      Positioned(
                        right: -6,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                          decoration: const BoxDecoration(
                            color: AppColors.spicyRed,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            badgeCount > 9 ? '9+' : '$badgeCount',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ).animate(target: selected ? 1 : 0).scaleXY(end: 1.03, duration: 180.ms),
        ),
      ),
    );
  }
}
