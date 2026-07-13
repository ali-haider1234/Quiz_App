import 'package:flutter/material.dart';

class AppColors {
  // Background gradient colors
  static const Color backgroundDark = Color(0xFF0D1117);
  static const Color backgroundSlate = Color(0xFF161B22);
  static const Color backgroundAccent = Color(0xFF1E1E38);

  // Surface & Cards
  static const Color cardSurface = Color(0xFF1E293B);
  static const Color cardBorder = Color(0xFF334155);

  // Brand Accents
  static const Color primaryIndigo = Color(0xFF6366F1);
  static const Color primaryPurple = Color(0xFF8B5CF6);
  static const Color accentPink = Color(0xFFEC4899);
  static const Color accentCyan = Color(0xFF06B6D4);

  // Quiz Option States
  static const Color optionDefaultBg = Color(0xFF1F2937);
  static const Color optionDefaultBorder = Color(0xFF374151);

  static const Color correctBg = Color(0xFF064E3B);
  static const Color correctBorder = Color(0xFF10B981);
  static const Color correctText = Color(0xFF6EE7B7);

  static const Color incorrectBg = Color(0xFF4C0519);
  static const Color incorrectBorder = Color(0xFFF43F5E);
  static const Color incorrectText = Color(0xFFFDA4AF);

  // Typography
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Gradients
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0B0F19),
      Color(0xFF111827),
      Color(0xFF1A1A32),
    ],
  );

  static const LinearGradient primaryButtonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF6366F1),
      Color(0xFF8B5CF6),
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E293B),
      Color(0xFF111827),
    ],
  );
}
