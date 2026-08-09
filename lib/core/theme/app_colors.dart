import 'package:flutter/material.dart';

class AppColors {
  // Brand Palettes
  static const Color brandPrimary = Color(0xFFF97316); // Vibrant Orange
  static const Color brandSecondary = Color(0xFFF59E0B); // Warm Amber
  static const Color brandDark = Color(0xFFC2410C); // Deep Orange
  
  // Backgrounds
  static const Color lightBg = Color(0xFFFAFAF9);
  static const Color lightSurface = Colors.white;
  static const Color darkBg = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);

  // Text
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  // Badges & Accents
  static const Color spicyRed = Color(0xFFEF4444);
  static const Color morningGold = Color(0xFFD97706);
  static const Color successGreen = Color(0xFF10B981);
  static const Color cardBorder = Color(0xFFFED7AA);

  // Glassmorphism Gradient Fill
  static const LinearGradient brandGradient = LinearGradient(
    colors: [Color(0xFFF97316), Color(0xFFF59E0B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
