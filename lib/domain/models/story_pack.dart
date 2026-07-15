import '../../core/constants/age_groups.dart';
import '../../core/constants/safety_themes.dart';
import 'activity.dart';
import 'comprehension_question.dart';
import 'discussion_prompt.dart';
import 'educator_guide.dart';
import 'localized_story_content.dart';
import 'story_page.dart';

class StoryPack {
  final String id;
  final String mascotId;
  final String regionId;
  final SafetyTheme safetyTheme;
  final List<AgeGroup> ageGroups;

  // Multi-language support (optional for backward compatibility)
  final List<String> availableLanguages;
  final String defaultLanguage;
  final Map<String, LocalizedStoryContent>? translations;

  // Legacy fields for backward compatibility with old single-language packs
  final String? _legacyTitle;
  final String? _legacySynopsis;
  final List<StoryPage>? _legacyPages;
  final EducatorGuide? _legacyEducatorGuide;
  final List<ComprehensionQuestion>? _legacyQuestions;

  bool get isMultilingual => translations != null;

  // Getters that work with both old and new formats
  String get title => isMultilingual ? getContent().title : _legacyTitle!;
  String get synopsis => isMultilingual ? getContent().synopsis : _legacySynopsis!;
  List<StoryPage> get pages => isMultilingual
      ? getContent().pages.map((p) => StoryPage(
          pageNumber: p.pageNumber,
          narration: p.narration,
          visualDescription: p.visualDescription,
          learningCue: p.learningCue,
          sceneColor: p.sceneColor,
          imageUrl: p.imageUrl,
        )).toList()
      : _legacyPages!;
  EducatorGuide get educatorGuide => isMultilingual
      ? EducatorGuide(
          learningObjectives: getContent().educatorGuide.learningObjectives,
          discussionPrompts: getContent().educatorGuide.discussionPrompts.map((p) => DiscussionPrompt(
            question: p.question,
            guidanceNote: p.guidanceNote,
            targetAge: p.targetAge,
          )).toList(),
          activities: getContent().educatorGuide.activities.map((a) => Activity(
            title: a.title,
            description: a.description,
            materials: a.materials,
            durationMinutes: a.durationMinutes,
            targetAge: a.targetAge,
          )).toList(),
          culturalContext: getContent().educatorGuide.culturalContext,
          safetyTakeaway: getContent().educatorGuide.safetyTakeaway,
        )
      : _legacyEducatorGuide!;
  List<ComprehensionQuestion> get questions => isMultilingual
      ? getContent().questions.map((q) => ComprehensionQuestion(
          id: q.id,
          questionText: q.questionText,
          options: q.options,
          correctIndex: q.correctIndex,
          explanation: q.explanation,
          mascotEncouragement: q.mascotEncouragement,
        )).toList()
      : _legacyQuestions ?? [];

  // Constructor for both old and new formats
  const StoryPack({
    required this.id,
    required this.mascotId,
    required this.regionId,
    required this.safetyTheme,
    required this.ageGroups,
    this.availableLanguages = const ['en'],
    this.defaultLanguage = 'en',
    this.translations,
    String? title,
    String? synopsis,
    List<StoryPage>? pages,
    EducatorGuide? educatorGuide,
    List<ComprehensionQuestion>? questions,
  })  : _legacyTitle = title,
        _legacySynopsis = synopsis,
        _legacyPages = pages,
        _legacyEducatorGuide = educatorGuide,
        _legacyQuestions = questions;

  /// Get content in specified language, fallback to default if not available
  LocalizedStoryContent getContent([String? languageCode]) {
    if (!isMultilingual) {
      throw StateError('Cannot get localized content from legacy single-language pack');
    }
    final lang = languageCode ?? defaultLanguage;
    return translations![lang] ?? translations![defaultLanguage]!;
  }

  /// Check if a language is available for this pack
  bool hasLanguage(String languageCode) {
    if (!isMultilingual) return languageCode == defaultLanguage;
    return translations!.containsKey(languageCode);
  }
}

