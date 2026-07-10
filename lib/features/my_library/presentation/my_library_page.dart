import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/story_packs/story_pack_registry.dart';
import '../providers/library_providers.dart';

class MyLibraryPage extends ConsumerWidget {
  const MyLibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarksProvider);
    final progress = ref.watch(readingProgressProvider);

    final allEntries = <String>{...bookmarks};
    for (final key in progress.keys) {
      if (progress[key]!.lastPageRead > 0 || progress[key]!.completed) {
        allEntries.add(key);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Library')),
      body: allEntries.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 80,
                    color: AnimalColors.textTertiary,
                  ),
                  const SizedBox(height: Dimensions.md),
                  Text(
                    'Your library is empty',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AnimalColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: Dimensions.sm),
                  Text(
                    'Bookmark stories or start reading to see them here',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Dimensions.lg),
                  ElevatedButton(
                    onPressed: () => context.go('/browse'),
                    child: const Text('Browse Stories'),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(Dimensions.md),
              itemCount: allEntries.length,
              separatorBuilder: (_, _) => const SizedBox(height: Dimensions.sm),
              itemBuilder: (context, index) {
                final packId = allEntries.elementAt(index);
                final pack = StoryPackRegistry.getById(packId);
                final packProgress = progress[packId];
                final isBookmarked = bookmarks.contains(packId);
                final progressFraction = packProgress != null
                    ? (packProgress.lastPageRead + 1) / pack.pages.length
                    : 0.0;

                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => context.pushNamed(
                      'story-pack-detail',
                      pathParameters: {'packId': packId},
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.md),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: pack.safetyTheme.color.withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: BorderRadius.circular(
                                Dimensions.radiusMd,
                              ),
                            ),
                            child: Icon(
                              packProgress?.completed == true
                                  ? Icons.check_circle
                                  : pack.safetyTheme.icon,
                              color: packProgress?.completed == true
                                  ? AnimalColors.success
                                  : pack.safetyTheme.color,
                            ),
                          ),
                          const SizedBox(width: Dimensions.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pack.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                if (packProgress?.completed == true)
                                  Text(
                                    'Completed',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: AnimalColors.success),
                                  )
                                else if (packProgress != null &&
                                    packProgress.lastPageRead > 0) ...[
                                  Text(
                                    'Page ${packProgress.lastPageRead + 1} of ${pack.pages.length}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 4),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: progressFraction,
                                      backgroundColor: AnimalColors.border,
                                      color: AnimalColors.primary,
                                      minHeight: 4,
                                    ),
                                  ),
                                ] else
                                  Text(
                                    'Not started',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                              ],
                            ),
                          ),
                          if (isBookmarked)
                            IconButton(
                              icon: const Icon(
                                Icons.bookmark,
                                color: AnimalColors.primary,
                              ),
                              onPressed: () => ref
                                  .read(bookmarksProvider.notifier)
                                  .toggle(packId),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
