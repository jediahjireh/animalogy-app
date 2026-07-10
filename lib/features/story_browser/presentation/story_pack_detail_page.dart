import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/regions.dart';
import '../../../core/providers/app_mode_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/mascots/mascot_registry.dart';
import '../../../data/story_packs/story_pack_registry.dart';
import '../../../domain/models/app_mode.dart';
import '../../my_library/providers/library_providers.dart';

class StoryPackDetailPage extends ConsumerWidget {
  final String packId;

  const StoryPackDetailPage({super.key, required this.packId});

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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? AnimalColors.primary : null,
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
                borderRadius: BorderRadius.circular(Dimensions.radiusLg),
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
                  Icon(
                    mascot.icon,
                    size: 32,
                    color: pack.safetyTheme.color.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.lg),
            Text(pack.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: Dimensions.sm),
            Row(
              children: [
                Icon(mascot.icon, size: 20, color: AnimalColors.textSecondary),
                const SizedBox(width: 6),
                Text(
                  '${mascot.name} the ${mascot.species}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                if (region != null)
                  Text(
                    '${region.emoji} ${region.name}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
            const SizedBox(height: Dimensions.md),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: pack.safetyTheme.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(Dimensions.radiusRound),
                  ),
                  child: Text(
                    pack.safetyTheme.label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: pack.safetyTheme.color,
                    ),
                  ),
                ),
                ...pack.ageGroups.map(
                  (age) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AnimalColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(
                        Dimensions.radiusRound,
                      ),
                    ),
                    child: Text(
                      'Ages ${age.label}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.lg),
            Text(pack.synopsis, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: Dimensions.lg),
            if (packProgress != null && !packProgress.completed)
              Text(
                'You\'re on page ${packProgress.lastPageRead + 1} of ${pack.pages.length}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AnimalColors.primary),
              ),
            if (packProgress != null && packProgress.completed)
              Container(
                padding: const EdgeInsets.all(Dimensions.md),
                decoration: BoxDecoration(
                  color: AnimalColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Dimensions.radiusMd),
                  border: Border.all(
                    color: AnimalColors.success.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AnimalColors.success,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Completed',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AnimalColors.success,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: Dimensions.lg),
            ElevatedButton.icon(
              onPressed: () => context.pushNamed(
                'story-viewer',
                pathParameters: {'packId': packId},
              ),
              icon: Icon(
                packProgress != null && !packProgress.completed
                    ? Icons.play_arrow
                    : Icons.auto_stories,
              ),
              label: Text(
                packProgress != null && !packProgress.completed
                    ? 'Continue Reading'
                    : packProgress?.completed == true
                    ? 'Read Again'
                    : 'Start Reading',
              ),
            ),
            if (appMode == AppMode.educator) ...[
              const SizedBox(height: Dimensions.md),
              OutlinedButton.icon(
                onPressed: () => context.pushNamed(
                  'educator-guide',
                  pathParameters: {'packId': packId},
                ),
                icon: const Icon(Icons.school),
                label: const Text('Educator Guide'),
              ),
            ],
            const SizedBox(height: Dimensions.lg),
            if (appMode == AppMode.educator) ...[
              Text(
                'Learning Objectives',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: Dimensions.sm),
              ...pack.educatorGuide.learningObjectives.map(
                (obj) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
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
