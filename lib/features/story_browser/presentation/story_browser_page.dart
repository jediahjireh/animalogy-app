import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/age_groups.dart';
import '../../../core/constants/regions.dart';
import '../../../core/constants/safety_themes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../providers/story_browser_providers.dart';

class StoryBrowserPage extends ConsumerWidget {
  const StoryBrowserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packs = ref.watch(filteredPacksProvider);
    final regionFilter = ref.watch(regionFilterProvider);
    final themeFilter = ref.watch(themeFilterProvider);
    final ageFilter = ref.watch(ageFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Stories'),
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
                _FilterChip(
                  label: regionFilter?.name ?? 'Region',
                  selected: regionFilter != null,
                  onTap: () => _showRegionFilter(context, ref),
                ),
                const SizedBox(width: Dimensions.sm),
                _FilterChip(
                  label: themeFilter?.label ?? 'Theme',
                  selected: themeFilter != null,
                  onTap: () => _showThemeFilter(context, ref),
                ),
                const SizedBox(width: Dimensions.sm),
                _FilterChip(
                  label: ageFilter?.label ?? 'Age',
                  selected: ageFilter != null,
                  onTap: () => _showAgeFilter(context, ref),
                ),
                if (regionFilter != null ||
                    themeFilter != null ||
                    ageFilter != null) ...[
                  const SizedBox(width: Dimensions.sm),
                  ActionChip(
                    avatar: const Icon(Icons.clear, size: 16),
                    label: const Text('Clear'),
                    onPressed: () {
                      ref.read(regionFilterProvider.notifier).state = null;
                      ref.read(themeFilterProvider.notifier).state = null;
                      ref.read(ageFilterProvider.notifier).state = null;
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: Dimensions.sm),
          Expanded(
            child: packs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off,
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
                : ListView.separated(
                    padding: const EdgeInsets.all(Dimensions.md),
                    itemCount: packs.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: Dimensions.sm),
                    itemBuilder: (context, index) {
                      final pack = packs[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => context.pushNamed(
                            'story-pack-detail',
                            pathParameters: {'packId': pack.id},
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      pack.safetyTheme.color.withValues(
                                        alpha: 0.3,
                                      ),
                                      pack.safetyTheme.color.withValues(
                                        alpha: 0.1,
                                      ),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    pack.safetyTheme.icon,
                                    size: 48,
                                    color: pack.safetyTheme.color,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(Dimensions.md),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pack.title,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: pack.safetyTheme.color
                                                .withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.radiusRound,
                                            ),
                                          ),
                                          child: Text(
                                            pack.safetyTheme.label,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: pack.safetyTheme.color,
                                                ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        ...pack.ageGroups.map(
                                          (age) => Padding(
                                            padding: const EdgeInsets.only(
                                              right: 4,
                                            ),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color:
                                                    AnimalColors.surfaceVariant,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      Dimensions.radiusRound,
                                                    ),
                                              ),
                                              child: Text(
                                                age.label,
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.labelSmall,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      pack.synopsis,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
            title: const Text('All Regions'),
            onTap: () {
              ref.read(regionFilterProvider.notifier).state = null;
              Navigator.pop(context);
            },
          ),
          ...Region.values.map(
            (r) => ListTile(
              leading: Icon(r.icon, color: r.color),
              title: Text('${r.emoji} ${r.name}'),
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
            title: const Text('All Ages'),
            onTap: () {
              ref.read(ageFilterProvider.notifier).state = null;
              Navigator.pop(context);
            },
          ),
          ...AgeGroup.values.map(
            (a) => ListTile(
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.md,
          vertical: Dimensions.sm,
        ),
        decoration: BoxDecoration(
          color: selected ? AnimalColors.primaryLight : AnimalColors.surface,
          borderRadius: BorderRadius.circular(Dimensions.radiusRound),
          border: Border.all(
            color: selected ? AnimalColors.primary : AnimalColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: selected
                    ? AnimalColors.primary
                    : AnimalColors.textSecondary,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: 18,
              color: selected
                  ? AnimalColors.primary
                  : AnimalColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
