import 'discussion_prompt.dart';
import 'activity.dart';

class EducatorGuide {
  final List<String> learningObjectives;
  final List<DiscussionPrompt> discussionPrompts;
  final List<Activity> activities;
  final String culturalContext;
  final String safetyTakeaway;

  const EducatorGuide({
    required this.learningObjectives,
    required this.discussionPrompts,
    required this.activities,
    required this.culturalContext,
    required this.safetyTakeaway,
  });
}
