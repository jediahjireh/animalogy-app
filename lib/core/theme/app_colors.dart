import 'package:flutter/material.dart';

abstract final class AnimalColors {
  static const Color primary = Color(0xFFD4733B);
  static const Color primaryLight = Color(0xFFFFF3EC);
  static const Color primaryDark = Color(0xFFA85A2A);

  static const Color secondary = Color(0xFF4A7C59);
  static const Color secondaryLight = Color(0xFFE8F5E9);

  static const Color accent = Color(0xFFE8B84B);

  static const Color success = Color(0xFF66BB6A);
  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFFB74D);

  static const Color background = Color(0xFFFAF6F1);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5EDE3);

  static const Color textPrimary = Color(0xFF3E2C1C);
  static const Color textSecondary = Color(0xFF7A6652);
  static const Color textTertiary = Color(0xFFA89482);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color regionAfrica = Color(0xFFD4733B);
  static const Color regionAustralia = Color(0xFFC9843E);
  static const Color regionIndia = Color(0xFF8B6914);
  static const Color regionBrazil = Color(0xFF2E7D32);
  static const Color regionNorthAmerica = Color(0xFF5D4037);

  static const Color border = Color(0xFFDDD0C4);
  static const Color divider = Color(0xFFE8DDD0);

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
