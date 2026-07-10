import '../../core/constants/age_groups.dart';

class Activity {
  final String title;
  final String description;
  final List<String> materials;
  final int durationMinutes;
  final AgeGroup targetAge;

  const Activity({
    required this.title,
    required this.description,
    required this.materials,
    required this.durationMinutes,
    required this.targetAge,
  });
}
