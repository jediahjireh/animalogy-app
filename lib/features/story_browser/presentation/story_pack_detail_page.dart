import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/regions.dart';
import '../../../core/providers/app_mode_provider.dart';
import '../../../core/providers/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/mascots/mascot_registry.dart';
import '../../../data/story_packs/story_pack_registry.dart';
import '../../../domain/models/app_mode.dart';
import '../../../shared/widgets/badge_chip.dart';
import '../../../shared/widgets/cartoon_button.dart';
import '../../../shared/widgets/print_options_sheet.dart';
import '../../../shared/widgets/star_display.dart';
import '../../my_library/providers/library_providers.dart';

class StoryPackDetailPage extends ConsumerWidget {
  final String packId;

  const StoryPackDetailPage({super.key, required this.packId});

  static const Map<String, String> _languageNames = {
    'en': 'English',
    'af': 'Afrikaans',
    'ro': 'Română',
  };

  static const Map<String, String> _languageFlags = {
    'en': '🇬🇧',
    'af': '🇿🇦',
    'ro': '🇷🇴',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pack = StoryPackRegistry.getById(packId);
    final mascot = MascotRegistry.getById(pack.mascotId);
    final region = Region.fromId(pack.regionId);
    final appMode = ref.watch(appModeProvider);
    final bookmarks = ref.watch(bookmarksProvider);
    final isBookmarked = bookmarks.contains(packId);
    final progress = ref.watch(readingProgressProvider);
    final packProgress = progress[packId];
    final scores = ref.watch(storyScoresProvider);
    final score = scores[packId];
    final selectedLanguage =
        ref.watch(packLanguageForIdProvider(packId)) ?? pack.defaultLanguage;

    final regionColor = region?.color ?? AnimalColors.primary;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: isBookmarked ? AnimalColors.error : null,
            ),
            onPressed: () =>
                ref.read(bookmarksProvider.notifier).toggle(packId),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    pack.safetyTheme.color.withValues(alpha: 0.3),
                    pack.safetyTheme.color.withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(Dimensions.radiusXl),
                border: Border.all(
                  color: pack.safetyTheme.color.withValues(alpha: 0.3),
                  width: Dimensions.borderMd,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    pack.safetyTheme.icon,
                    size: 64,
                    color: pack.safetyTheme.color,
                  ),
                  const SizedBox(height: Dimensions.sm),
                  ClipOval(
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: mascot.imageUrl.isNotEmpty
                          ? Image.network(
                              mascot.imageUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    mascot.icon,
                                    size: 32,
                                    color: pack.safetyTheme.color.withValues(
                                      alpha: 0.6,
                                    ),
                                  ),
                            )
                          : Icon(
                              mascot.icon,
                              size: 32,
                              color: pack.safetyTheme.color.withValues(
                                alpha: 0.6,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.lg),
            Text(
              pack.titleIn(selectedLanguage),
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: Dimensions.sm),
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: regionColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: regionColor, width: 1.5),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: mascot.imageUrl.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(2),
                          child: Image.network(
                            mascot.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(mascot.icon, size: 14, color: regionColor),
                          ),
                        )
                      : Icon(mascot.icon, size: 14, color: regionColor),
                ),
                const SizedBox(width: Dimensions.sm),
                Text(
                  '${mascot.name} the ${mascot.species}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                if (region != null)
                  BadgeChip(
                    label: region.name,
                    icon: region.icon,
                    color: regionColor,
                    selected: true,
                  ),
              ],
            ),
            const SizedBox(height: Dimensions.md),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                BadgeChip(
                  label: pack.safetyTheme.label,
                  icon: pack.safetyTheme.icon,
                  color: pack.safetyTheme.color,
                  selected: true,
                ),
                ...pack.ageGroups.map(
                  (age) => BadgeChip(
                    label: 'Ages ${age.label}',
                    icon: Icons.people_outline,
                  ),
                ),
              ],
            ),
            if (pack.availableLanguages.length > 1) ...[
              const SizedBox(height: Dimensions.md),
              Row(
                children: [
                  Icon(
                    Icons.language_rounded,
                    size: 18,
                    color: AnimalColors.textSecondary,
                  ),
                  const SizedBox(width: Dimensions.xs),
                  Text(
                    'Language:',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AnimalColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: Dimensions.sm),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: pack.availableLanguages.map((langCode) {
                          final isSelected = langCode == selectedLanguage;
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: ChoiceChip(
                              label: Text(
                                '${_languageFlags[langCode] ?? ''} ${_languageNames[langCode] ?? langCode}'
                                    .trim(),
                              ),
                              selected: isSelected,
                              onSelected: (_) {
                                ref
                                    .read(packLanguageProvider.notifier)
                                    .setLanguage(packId, langCode);
                              },
                              selectedColor: regionColor.withValues(alpha: 0.2),
                              backgroundColor: AnimalColors.surface,
                              side: BorderSide(
                                color: isSelected
                                    ? regionColor
                                    : AnimalColors.border,
                                width: isSelected ? 1.5 : 1,
                              ),
                              labelStyle: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: isSelected
                                    ? regionColor
                                    : AnimalColors.textSecondary,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (score != null) ...[
              const SizedBox(height: Dimensions.md),
              Row(
                children: [
                  StarDisplay(stars: score.stars, size: 28),
                  const SizedBox(width: Dimensions.sm),
                  Text(
                    '${score.correctAnswers}/${score.totalQuestions} correct',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AnimalColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: Dimensions.lg),
            Text(
              pack.synopsisIn(selectedLanguage),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            const SizedBox(height: Dimensions.lg),
            if (packProgress != null && !packProgress.completed)
              Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.md),
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.md),
                  decoration: BoxDecoration(
                    color: AnimalColors.primaryLight,
                    borderRadius: BorderRadius.circular(Dimensions.radiusXl),
                    border: Border.all(
                      color: AnimalColors.primary.withValues(alpha: 0.3),
                      width: Dimensions.borderThin,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.auto_stories_rounded,
                        color: AnimalColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Page ${packProgress.lastPageRead + 1} of ${pack.pagesIn(selectedLanguage).length}',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AnimalColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (packProgress != null && packProgress.completed)
              Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.md),
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.md),
                  decoration: BoxDecoration(
                    color: AnimalColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Dimensions.radiusXl),
                    border: Border.all(
                      color: AnimalColors.success.withValues(alpha: 0.3),
                      width: Dimensions.borderThin,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        color: AnimalColors.success,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Completed',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AnimalColors.success,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            CartoonButton(
              label: packProgress != null && !packProgress.completed
                  ? 'Continue Reading'
                  : packProgress?.completed == true
                  ? 'Read Again'
                  : 'Start Reading',
              icon: packProgress != null && !packProgress.completed
                  ? Icons.play_arrow_rounded
                  : Icons.auto_stories_rounded,
              onPressed: () => context.pushNamed(
                'story-viewer',
                pathParameters: {'packId': packId},
              ),
              expanded: true,
            ),
            if (appMode == AppMode.educator) ...[
              const SizedBox(height: Dimensions.md),
              CartoonButton(
                label: 'Educator Guide',
                icon: Icons.school_rounded,
                onPressed: () => context.pushNamed(
                  'educator-guide',
                  pathParameters: {'packId': packId},
                ),
                color: AnimalColors.secondary,
                expanded: true,
              ),
            ],
            if (appMode == AppMode.educator) ...[
              const SizedBox(height: Dimensions.md),
              CartoonButton(
                label: 'Printable Resources',
                icon: Icons.print_rounded,
                onPressed: () =>
                    PrintOptionsSheet.show(context, pack, selectedLanguage),
                color: AnimalColors.info,
                expanded: true,
              ),
            ],
            if (appMode == AppMode.educator) ...[
              const SizedBox(height: Dimensions.xl),
              Text(
                'Learning Objectives',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: Dimensions.sm),
              ...pack
                  .educatorGuideIn(selectedLanguage)
                  .learningObjectives
                  .map(
                    (obj) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            size: 18,
                            color: AnimalColors.secondary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              obj,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ],
        ),
      ),
    );
  }
}
