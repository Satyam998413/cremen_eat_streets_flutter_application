import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import 'app_button.dart';

/// Shared empty-state layout (icon + title + optional subtitle/CTA), animated
/// with the same fade+scale entrance `home_screen.dart` already used for its
/// search-empty state — promoted here so every screen's empty state looks
/// and moves the same way instead of each hand-rolling its own.
class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.ctaLabel,
    this.onCta,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? ctaLabel;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: AppColors.brandPrimary),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7)),
              ),
            ],
            if (ctaLabel != null && onCta != null) ...[
              const SizedBox(height: 20),
              AppButton(label: ctaLabel!, onPressed: onCta!),
            ],
          ],
        ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.8, 0.8)),
      ),
    );
  }
}
