import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  const BottomNavBar({
    super.key,
    this.selectedIndex = 0,
    this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Row(
            children: [
              Expanded(
                child: _NavItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  label: 'Home',
                  selected: selectedIndex == 0,
                  onTap: () => onDestinationSelected?.call(0),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _NavItem(
                  icon: Icons.shopping_bag_outlined,
                  selectedIcon: Icons.shopping_bag,
                  label: 'Cart',
                  selected: selectedIndex == 1,
                  onTap: () => onDestinationSelected?.call(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.brandPrimary.withValues(alpha: 0.16)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? selectedIcon : icon,
              color: selected ? AppColors.brandPrimary : Colors.white70,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: selected ? AppColors.brandPrimary : Colors.white70,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
