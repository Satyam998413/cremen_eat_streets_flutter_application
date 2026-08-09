import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        selected: isSelected,
        selectedColor: AppColors.brandPrimary,
        backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
        side: BorderSide(
          color: isSelected ? AppColors.brandPrimary : AppColors.cardBorder,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: (_) => onTap(),
      ),
    );
  }
}
