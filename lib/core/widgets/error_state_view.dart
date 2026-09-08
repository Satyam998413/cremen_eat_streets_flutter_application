import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import 'app_button.dart';

/// Shared error-state layout, promoted from the private `_ErrorView` that
/// `order_tracking_screen.dart` already had (the most mature error UI in the
/// app) so every failed load looks and behaves the same way.
class ErrorStateView extends StatelessWidget {
  const ErrorStateView({
    super.key,
    required this.message,
    this.actionLabel = 'Back to Menu',
    this.onAction,
    this.icon = Icons.error_outline,
  });

  final String message;
  final String actionLabel;
  final VoidCallback? onAction;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: AppColors.spicyRed),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            if (onAction != null) ...[
              const SizedBox(height: 20),
              AppButton(label: actionLabel, onPressed: onAction!),
            ],
          ],
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.15, duration: 400.ms, curve: Curves.easeOutCubic),
      ),
    );
  }
}
