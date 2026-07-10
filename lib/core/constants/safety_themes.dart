import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum SafetyTheme {
  onlineDeception(
    label: 'Online Deception',
    description: 'Spotting when someone is not telling the truth.',
    icon: Icons.shield_outlined,
    color: AnimalColors.error,
  ),
  falseAlarms(
    label: 'False Alarms',
    description: 'Learning to check facts before panicking.',
    icon: Icons.warning_amber_outlined,
    color: AnimalColors.warning,
  ),
  flatteryManipulation(
    label: 'Flattery & Manipulation',
    description: 'Recognizing when kindness hides selfish intentions.',
    icon: Icons.chat_bubble_outline,
    color: AnimalColors.accent,
  ),
  hiddenDanger(
    label: 'Hidden Danger',
    description: 'Noticing when something safe-looking is not.',
    icon: Icons.visibility_off_outlined,
    color: AnimalColors.secondary,
  ),
  betrayalOfTrust(
    label: 'Betrayal of Trust',
    description: 'Understanding who deserves trust and why.',
    icon: Icons.heart_broken_outlined,
    color: AnimalColors.primaryDark,
  );

  const SafetyTheme({
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String label;
  final String description;
  final IconData icon;
  final Color color;
}
