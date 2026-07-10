import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/age_groups.dart';
import '../../../core/constants/regions.dart';
import '../../../core/constants/safety_themes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../shared/widgets/badge_chip.dart';
import '../../../shared/widgets/cartoon_card.dart';
import '../../../shared/widgets/star_display.dart';
import '../../my_library/providers/library_providers.dart';
import '../providers/story_browser_providers.dart';

class StoryBrowserPage extends ConsumerWidget {
  const StoryBrowserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packs = ref.watch(filteredPacksProvider);
    final regionFilter = ref.watch(regionFilterProvider);
    final themeFilter = ref.watch(themeFilterProvider);
    final ageFilter = ref.watch(ageFilterProvider);
    final scores = ref.watch(storyScoresProvider);

    final hasFilters =
        regionFilter != null || themeFilter != null || ageFilter != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Browse Stories',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.md),
            child: Row(
              children: [
                BadgeChip(
                  label: regionFilter?.name ?? 'Region',
                  icon: regionFilter?.icon ?? Icons.public,
                  color: regionFilter?.color,
                  selected: regionFilter != null,
                  onTap: () => _showRegionFilter(context, ref),
                ),
                const SizedBox(width: Dimensions.sm),
                BadgeChip(
                  label: themeFilter?.label ?? 'Theme',
                  icon: themeFilter?.icon ?? Icons.shield_outlined,
                  color: themeFilter?.color,
                  selected: themeFilter != null,
                  onTap: () => _showThemeFilter(context, ref),
                ),
                const SizedBox(width: Dimensions.sm),
                BadgeChip(
                  label: ageFilter?.label ?? 'Age',
                  icon: Icons.people_outline,
                  selected: ageFilter != null,
                  onTap: () => _showAgeFilter(context, ref),
                ),
                if (hasFilters) ...[
                  const SizedBox(width: Dimensions.sm),
                  BadgeChip(
                    label: 'Clear',
                    icon: Icons.clear_rounded,
                    color: AnimalColors.error,
                    onTap: () {
                      ref.read(regionFilterProvider.notifier).state = null;
                      ref.read(themeFilterProvider.notifier).state = null;
                      ref.read(ageFilterProvider.notifier).state = null;
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: Dimensions.md),
          Expanded(
            child: packs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 64,
                          color: AnimalColors.textTertiary,
                        ),
                        const SizedBox(height: Dimensions.md),
                        Text(
                          'No stories match your filters',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AnimalColors.textTertiary),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(Dimensions.md),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.72,
                          crossAxisSpacing: Dimensions.md,
                          mainAxisSpacing: Dimensions.md,
                        ),
                    itemCount: packs.length,
                    itemBuilder: (context, index) {
                      final pack = packs[index];
                      final score = scores[pack.id];
                      return CartoonCard(
                        borderColor: pack.safetyTheme.color,
                        rotate: true,
                        onTap: () => context.pushNamed(
                          'story-pack-detail',
                          pathParameters: {'packId': pack.id},
                        ),
                        padding: const EdgeInsets.all(Dimensions.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    pack.safetyTheme.color.withValues(
                                      alpha: 0.3,
                                    ),
                                    pack.safetyTheme.color.withValues(
                                      alpha: 0.08,
                                    ),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radiusLg,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  pack.safetyTheme.icon,
                                  size: 40,
                                  color: pack.safetyTheme.color,
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.sm),
                            Text(
                              pack.title,
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: Dimensions.xs),
                            Row(
                              children: [
                                Icon(
                                  pack.safetyTheme.icon,
                                  size: 12,
                                  color: pack.safetyTheme.color,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    pack.safetyTheme.label,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: pack.safetyTheme.color,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            if (score != null)
                              StarDisplay(stars: score.stars, size: 16),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showRegionFilter(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.public),
            title: const Text('All Regions'),
            onTap: () {
              ref.read(regionFilterProvider.notifier).state = null;
              Navigator.pop(context);
            },
          ),
          ...Region.values.map(
            (r) => ListTile(
              leading: Icon(r.icon, color: r.color),
              title: Text(r.name),
              onTap: () {
                ref.read(regionFilterProvider.notifier).state = r;
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showThemeFilter(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.shield_outlined),
            title: const Text('All Themes'),
            onTap: () {
              ref.read(themeFilterProvider.notifier).state = null;
              Navigator.pop(context);
            },
          ),
          ...SafetyTheme.values.map(
            (t) => ListTile(
              leading: Icon(t.icon, color: t.color),
              title: Text(t.label),
              onTap: () {
                ref.read(themeFilterProvider.notifier).state = t;
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAgeFilter(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('All Ages'),
            onTap: () {
              ref.read(ageFilterProvider.notifier).state = null;
              Navigator.pop(context);
            },
          ),
          ...AgeGroup.values.map(
            (a) => ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text('${a.displayName} (${a.label})'),
              onTap: () {
                ref.read(ageFilterProvider.notifier).state = a;
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
