import 'localized_discussion_prompt.dart';
import 'localized_activity.dart';

/// Localized version of educator guide
class LocalizedEducatorGuide {
  final List<String> learningObjectives;
  final List<LocalizedDiscussionPrompt> discussionPrompts;
  final List<LocalizedActivity> activities;
  final String culturalContext;
  final String safetyTakeaway;

  const LocalizedEducatorGuide({
    required this.learningObjectives,
    required this.discussionPrompts,
    required this.activities,
    required this.culturalContext,
    required this.safetyTakeaway,
  });
}
