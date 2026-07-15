import 'localized_story_page.dart';
import 'localized_educator_guide.dart';
import 'localized_comprehension_question.dart';

/// Holds all translatable content for a story pack in a specific language
class LocalizedStoryContent {
  final String title;
  final String synopsis;
  final List<LocalizedStoryPage> pages;
  final LocalizedEducatorGuide educatorGuide;
  final List<LocalizedComprehensionQuestion> questions;

  const LocalizedStoryContent({
    required this.title,
    required this.synopsis,
    required this.pages,
    required this.educatorGuide,
    required this.questions,
  });
}
