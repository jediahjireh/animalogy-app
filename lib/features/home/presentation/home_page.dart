import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/regions.dart';
import '../../../core/providers/app_mode_provider.dart';
import '../../../core/providers/region_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/mascots/mascot_registry.dart';
import '../../../data/story_packs/story_pack_registry.dart';
import '../../../domain/models/app_mode.dart';
import '../../../features/my_library/providers/library_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final region = ref.watch(selectedRegionProvider);
    final appMode = ref.watch(appModeProvider);
    final progress = ref.watch(readingProgressProvider);

    final mascot = region != null
        ? MascotRegistry.getByRegion(region.id)
        : MascotRegistry.allMascots.first;

    final regionPacks = region != null
        ? StoryPackRegistry.getByRegion(region.id)
        : StoryPackRegistry.allPacks;

    final inProgressPack = progress.entries
        .where((e) => !e.value.completed && e.value.lastPageRead > 0)
        .toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimensions.lg,
                  Dimensions.lg,
                  Dimensions.lg,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appMode == AppMode.child
                                    ? 'Hi there!'
                                    : 'Welcome back',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${mascot.name} says: "${mascot.catchphrase}"',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        _ModeToggle(
                          mode: appMode,
                          onToggle: () =>
                              ref.read(appModeProvider.notifier).toggle(),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.lg),
                    _MascotBanner(mascot: mascot, region: region),
                  ],
                ),
              ),
            ),
            if (inProgressPack.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Continue Reading',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: Dimensions.sm),
                      ...inProgressPack.map((entry) {
                        final pack = StoryPackRegistry.getById(entry.key);
                        return Card(
                          child: ListTile(
                            leading: Icon(
                              Icons.auto_stories,
                              color: AnimalColors.primary,
                            ),
                            title: Text(pack.title),
                            subtitle: Text(
                              'Page ${entry.value.lastPageRead + 1} of ${pack.pages.length}',
                            ),
                            trailing: Icon(
                              Icons.play_arrow,
                              color: AnimalColors.primary,
                            ),
                            onTap: () => context.pushNamed(
                              'story-viewer',
                              pathParameters: {'packId': pack.id},
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimensions.lg,
                  Dimensions.sm,
                  Dimensions.lg,
                  Dimensions.sm,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      region != null
                          ? 'Stories from ${region.name}'
                          : 'All Stories',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton(
                      onPressed: () => context.go('/browse'),
                      child: const Text('See All'),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.lg),
              sliver: SliverList.separated(
                itemCount: regionPacks.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: Dimensions.sm),
                itemBuilder: (context, index) {
                  final pack = regionPacks[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => context.pushNamed(
                        'story-pack-detail',
                        pathParameters: {'packId': pack.id},
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
                                pack.safetyTheme.icon,
                                color: pack.safetyTheme.color,
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
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    pack.safetyTheme.label,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: pack.safetyTheme.color,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: AnimalColors.textTertiary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: Dimensions.xl)),
            if (appMode == AppMode.educator)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.lg,
                  ),
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/skills'),
                    icon: const Icon(Icons.psychology),
                    label: const Text('View Skills Registry'),
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: Dimensions.xxl)),
          ],
        ),
      ),
    );
  }
}

class _ModeToggle extends StatelessWidget {
  final AppMode mode;
  final VoidCallback onToggle;

  const _ModeToggle({required this.mode, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.md,
          vertical: Dimensions.sm,
        ),
        decoration: BoxDecoration(
          color: mode == AppMode.child
              ? AnimalColors.accent.withValues(alpha: 0.2)
              : AnimalColors.secondary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(Dimensions.radiusRound),
          border: Border.all(
            color: mode == AppMode.child
                ? AnimalColors.accent
                : AnimalColors.secondary,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              mode == AppMode.child ? Icons.child_care : Icons.school,
              size: 18,
              color: mode == AppMode.child
                  ? AnimalColors.accent
                  : AnimalColors.secondary,
            ),
            const SizedBox(width: 6),
            Text(
              mode == AppMode.child ? 'Child' : 'Educator',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: mode == AppMode.child
                    ? AnimalColors.accent
                    : AnimalColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MascotBanner extends StatelessWidget {
  final dynamic mascot;
  final Region? region;

  const _MascotBanner({required this.mascot, required this.region});

  @override
  Widget build(BuildContext context) {
    final color = region?.color ?? AnimalColors.primary;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimensions.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(Dimensions.radiusLg),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: Dimensions.mascotAvatarLg,
            height: Dimensions.mascotAvatarLg,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(mascot.icon, size: 48, color: color),
          ),
          const SizedBox(width: Dimensions.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${mascot.name} the ${mascot.species}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: color),
                ),
                const SizedBox(height: 4),
                Text(
                  mascot.safetyRole,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
