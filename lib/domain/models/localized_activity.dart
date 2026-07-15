import '../../core/constants/age_groups.dart';

/// Localized version of activity
class LocalizedActivity {
  final String title;
  final String description;
  final List<String> materials;
  final int durationMinutes;
  final AgeGroup targetAge;

  const LocalizedActivity({
    required this.title,
    required this.description,
    required this.materials,
    required this.durationMinutes,
    required this.targetAge,
  });
}
