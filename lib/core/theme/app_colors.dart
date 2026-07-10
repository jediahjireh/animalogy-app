import 'package:flutter/material.dart';

abstract final class AnimalColors {
  // Bold, saturated primary palette
  static const Color primary = Color(0xFFE85D1A);
  static const Color primaryLight = Color(0xFFFFF0E6);
  static const Color primaryDark = Color(0xFFB04010);

  static const Color secondary = Color(0xFF2E8B57);
  static const Color secondaryLight = Color(0xFFD4F5E0);

  static const Color accent = Color(0xFFFFC107);
  static const Color accentDark = Color(0xFFE5A800);

  static const Color success = Color(0xFF43A047);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF1E88E5);

  // Warm, inviting backgrounds
  static const Color background = Color(0xFFFFF8F0);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFFFF3E6);

  // High-contrast text
  static const Color textPrimary = Color(0xFF2D1B0E);
  static const Color textSecondary = Color(0xFF5C4033);
  static const Color textTertiary = Color(0xFF8D7560);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Vibrant region colors for cultural differentiation
  static const Color regionAfrica = Color(0xFFE85D1A);
  static const Color regionAustralia = Color(0xFFD4570A);
  static const Color regionIndia = Color(0xFFC68A00);
  static const Color regionBrazil = Color(0xFF1B8C3D);
  static const Color regionNorthAmerica = Color(0xFF6D4C2E);

  // Cartoon UI borders
  static const Color border = Color(0xFFCDBBA8);
  static const Color borderBold = Color(0xFF8B7355);
  static const Color divider = Color(0xFFE8DDD0);

  // Cartoon button shadows
  static const Color buttonShadow = Color(0xFF3D2814);
  static const Color cardShadow = Color(0x40000000);

  /// Blends [color] into [surface] for warm background tints that avoid the
  /// muddy grey problem caused by low-alpha overlays on dark colors.
  static Color tint(Color color, [double weight = 0.12]) =>
      Color.lerp(surface, color, weight)!;

  static Color regionColor(String regionId) {
    return switch (regionId) {
      'southern_africa' => regionAfrica,
      'australia' => regionAustralia,
      'india' => regionIndia,
      'brazil' => regionBrazil,
      'north_america' => regionNorthAmerica,
      _ => primary,
    };
  }
}
