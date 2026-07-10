import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/story_packs/story_pack_registry.dart';
import '../../../shared/widgets/cartoon_button.dart';
import '../../../shared/widgets/cartoon_card.dart';
import '../../../shared/widgets/star_display.dart';
import '../providers/library_providers.dart';

class MyLibraryPage extends ConsumerWidget {
  const MyLibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);
    final progress = ref.watch(readingProgressProvider);
    final scores = ref.watch(storyScoresProvider);

    final allEntries = <String>{...bookmarks};
    for (final key in progress.keys) {
      if (progress[key]!.lastPageRead > 0 || progress[key]!.completed) {
        allEntries.add(key);
      }
    }

    return Scaffold(
      backgroundColor: AnimalColors.background,
      appBar: AppBar(
        title: Text(
          'My Library',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: allEntries.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: Dimensions.mascotAvatarLg,
                      height: Dimensions.mascotAvatarLg,
                      decoration: BoxDecoration(
                        color: AnimalColors.primaryLight,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AnimalColors.border,
                          width: Dimensions.borderMd,
                        ),
                      ),
                      child: const Icon(
                        Icons.bookmark_border,
                        size: Dimensions.iconXl,
                        color: AnimalColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: Dimensions.lg),
                    Text(
                      'Your library is empty',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AnimalColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: Dimensions.sm),
                    Text(
                      'Bookmark stories or start reading to see them here',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AnimalColors.textTertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.lg),
                    CartoonButton(
                      label: 'Browse Stories',
                      icon: Icons.auto_stories,
                      onPressed: () => context.go('/browse'),
                      color: AnimalColors.secondary,
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(Dimensions.md),
              itemCount: allEntries.length,
              separatorBuilder: (_, _) => const SizedBox(height: Dimensions.md),
              itemBuilder: (context, index) {
                final packId = allEntries.elementAt(index);
                final pack = StoryPackRegistry.getById(packId);
                final packProgress = progress[packId];
                final score = scores[packId];
                final isBookmarked = bookmarks.contains(packId);
                final progressFraction = packProgress != null
                    ? (packProgress.lastPageRead + 1) / pack.pages.length
                    : 0.0;

                return CartoonCard(
                  borderColor: pack.safetyTheme.color,
                  onTap: () => context.pushNamed(
                    'story-pack-detail',
                    pathParameters: {'packId': packId},
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: pack.safetyTheme.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusMd,
                          ),
                          border: Border.all(
                            color: pack.safetyTheme.color.withValues(
                              alpha: 0.3,
                            ),
                            width: Dimensions.borderThin,
                          ),
                        ),
                        child: Icon(
                          packProgress?.completed == true
                              ? Icons.check_circle
                              : pack.safetyTheme.icon,
                          color: packProgress?.completed == true
                              ? AnimalColors.success
                              : pack.safetyTheme.color,
                          size: Dimensions.iconMd,
                        ),
                      ),
                      const SizedBox(width: Dimensions.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pack.title,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: Dimensions.xs),
                            if (packProgress?.completed == true) ...[
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 14,
                                    color: AnimalColors.success,
                                  ),
                                  const SizedBox(width: Dimensions.xs),
                                  Text(
                                    'Completed',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: AnimalColors.success,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                              if (score != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: Dimensions.xs,
                                  ),
                                  child: StarDisplay(
                                    stars: score.stars,
                                    size: 20,
                                  ),
                                ),
                            ] else if (packProgress != null &&
                                packProgress.lastPageRead > 0) ...[
                              Text(
                                'Page ${packProgress.lastPageRead + 1} of ${pack.pages.length}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: Dimensions.xs),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSm,
                                ),
                                child: LinearProgressIndicator(
                                  value: progressFraction,
                                  backgroundColor: AnimalColors.border,
                                  color: pack.safetyTheme.color,
                                  minHeight: 6,
                                ),
                              ),
                            ] else
                              Text(
                                'Not started',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: AnimalColors.textTertiary,
                                    ),
                              ),
                          ],
                        ),
                      ),
                      if (isBookmarked)
                        IconButton(
                          icon: const Icon(
                            Icons.favorite,
                            color: AnimalColors.primary,
                          ),
                          onPressed: () => ref
                              .read(bookmarksProvider.notifier)
                              .toggle(packId),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
