import 'story_page.dart';
import 'educator_guide.dart';
import 'comprehension_question.dart';

/// Holds all translatable content for a story pack in a specific language.
class LocalizedStoryContent {
  final String title;
  final String synopsis;
  final List<StoryPage> pages;
  final EducatorGuide educatorGuide;
  final List<ComprehensionQuestion> questions;

  const LocalizedStoryContent({
    required this.title,
    required this.synopsis,
    required this.pages,
    required this.educatorGuide,
    required this.questions,
  });
}
