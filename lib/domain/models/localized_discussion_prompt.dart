import '../../core/constants/age_groups.dart';

/// Localized version of discussion prompt
class LocalizedDiscussionPrompt {
  final String question;
  final String guidanceNote;
  final AgeGroup targetAge;

  const LocalizedDiscussionPrompt({
    required this.question,
    required this.guidanceNote,
    required this.targetAge,
  });
}
