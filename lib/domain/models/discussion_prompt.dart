import '../../core/constants/age_groups.dart';

class DiscussionPrompt {
  final String question;
  final String guidanceNote;
  final AgeGroup targetAge;

  const DiscussionPrompt({
    required this.question,
    required this.guidanceNote,
    required this.targetAge,
  });
}
