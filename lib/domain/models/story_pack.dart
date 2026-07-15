import '../../core/constants/age_groups.dart';
import '../../core/constants/safety_themes.dart';
import 'comprehension_question.dart';
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

  // Default-language getters (backward compatible — use default language)
  String get title => titleIn();
  String get synopsis => synopsisIn();
  List<StoryPage> get pages => pagesIn();
  EducatorGuide get educatorGuide => educatorGuideIn();
  List<ComprehensionQuestion> get questions => questionsIn();

  // Language-aware content accessors (work for both legacy and multilingual)
  String titleIn([String? languageCode]) {
    if (!isMultilingual) return _legacyTitle!;
    return getContent(languageCode).title;
  }

  String synopsisIn([String? languageCode]) {
    if (!isMultilingual) return _legacySynopsis!;
    return getContent(languageCode).synopsis;
  }

  List<StoryPage> pagesIn([String? languageCode]) {
    if (!isMultilingual) return _legacyPages!;
    return getContent(languageCode).pages;
  }

  EducatorGuide educatorGuideIn([String? languageCode]) {
    if (!isMultilingual) return _legacyEducatorGuide!;
    return getContent(languageCode).educatorGuide;
  }

  List<ComprehensionQuestion> questionsIn([String? languageCode]) {
    if (!isMultilingual) return _legacyQuestions ?? [];
    return getContent(languageCode).questions;
  }

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
  }) : _legacyTitle = title,
       _legacySynopsis = synopsis,
       _legacyPages = pages,
       _legacyEducatorGuide = educatorGuide,
       _legacyQuestions = questions;

  /// Get content in specified language, fallback to default if not available.
  /// Only works for multilingual packs — throws for legacy single-language packs.
  LocalizedStoryContent getContent([String? languageCode]) {
    if (!isMultilingual) {
      throw StateError(
        'Cannot get localized content from legacy single-language pack',
      );
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
