import '../../core/constants/age_groups.dart';
import '../../core/constants/safety_themes.dart';
import 'comprehension_question.dart';
import 'story_page.dart';
import 'educator_guide.dart';

class StoryPack {
  final String id;
  final String title;
  final String mascotId;
  final String regionId;
  final SafetyTheme safetyTheme;
  final List<AgeGroup> ageGroups;
  final String synopsis;
  final List<StoryPage> pages;
  final EducatorGuide educatorGuide;
  final List<ComprehensionQuestion> questions;

  const StoryPack({
    required this.id,
    required this.title,
    required this.mascotId,
    required this.regionId,
    required this.safetyTheme,
    required this.ageGroups,
    required this.synopsis,
    required this.pages,
    required this.educatorGuide,
    this.questions = const [],
  });
}
