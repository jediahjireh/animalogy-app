import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_dimensions.dart';
import '../../domain/models/app_mode.dart';

abstract final class AnimalTheme {
  static ThemeData light({required AppMode mode}) {
    final textTheme = mode == AppMode.child
        ? AnimalTypography.childTextTheme
        : AnimalTypography.textTheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AnimalColors.primary,
        primary: AnimalColors.primary,
        secondary: AnimalColors.secondary,
        surface: AnimalColors.surface,
        error: AnimalColors.error,
        brightness: Brightness.light,
      ),
      textTheme: textTheme,
      scaffoldBackgroundColor: AnimalColors.background,
      cardTheme: CardThemeData(
        color: AnimalColors.surface,
        elevation: Dimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusXl),
          side: const BorderSide(
            color: AnimalColors.border,
            width: Dimensions.borderThin,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AnimalColors.surfaceVariant,
        selectedColor: AnimalColors.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusRound),
          side: const BorderSide(
            color: AnimalColors.border,
            width: Dimensions.borderThin,
          ),
        ),
        labelStyle: textTheme.labelMedium,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.sm,
          vertical: Dimensions.xs,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AnimalColors.background,
        foregroundColor: AnimalColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AnimalColors.surface,
        indicatorColor: AnimalColors.primaryLight,
        elevation: 8,
        labelTextStyle: WidgetStatePropertyAll(
          textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AnimalColors.primary,
          foregroundColor: AnimalColors.textOnPrimary,
          elevation: Dimensions.buttonElevation,
          shadowColor: AnimalColors.buttonShadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusXl),
            side: const BorderSide(
              color: AnimalColors.primaryDark,
              width: Dimensions.borderMd,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.xl,
            vertical: Dimensions.md,
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: AnimalColors.textOnPrimary,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AnimalColors.primary,
          side: const BorderSide(
            color: AnimalColors.primary,
            width: Dimensions.borderMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusXl),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.xl,
            vertical: Dimensions.md,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AnimalColors.divider,
        thickness: 1.5,
      ),
    );
  }
}
