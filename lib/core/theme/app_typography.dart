import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AnimalTypography {
  static TextTheme get textTheme => TextTheme(
    displayLarge: GoogleFonts.nunito(
      fontSize: 48,
      fontWeight: FontWeight.w800,
      color: AnimalColors.textPrimary,
    ),
    displayMedium: GoogleFonts.nunito(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: AnimalColors.textPrimary,
    ),
    headlineLarge: GoogleFonts.nunito(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AnimalColors.textPrimary,
    ),
    headlineMedium: GoogleFonts.nunito(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AnimalColors.textPrimary,
    ),
    titleLarge: GoogleFonts.nunito(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AnimalColors.textPrimary,
    ),
    titleMedium: GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AnimalColors.textPrimary,
    ),
    bodyLarge: GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AnimalColors.textPrimary,
    ),
    bodyMedium: GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AnimalColors.textSecondary,
    ),
    bodySmall: GoogleFonts.nunito(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AnimalColors.textTertiary,
    ),
    labelLarge: GoogleFonts.nunito(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AnimalColors.textPrimary,
    ),
    labelMedium: GoogleFonts.nunito(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AnimalColors.textSecondary,
    ),
    labelSmall: GoogleFonts.nunito(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AnimalColors.textTertiary,
    ),
  );

  static TextTheme get childTextTheme => textTheme.copyWith(
    bodyLarge: GoogleFonts.nunito(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      height: 1.6,
      color: AnimalColors.textPrimary,
    ),
    bodyMedium: GoogleFonts.nunito(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: AnimalColors.textPrimary,
    ),
    titleLarge: GoogleFonts.nunito(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AnimalColors.textPrimary,
    ),
  );
}
