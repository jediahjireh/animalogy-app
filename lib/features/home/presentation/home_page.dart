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
import '../../../shared/widgets/cartoon_button.dart';
import '../../../shared/widgets/cartoon_card.dart';
import '../../../shared/widgets/mascot_avatar.dart';
import '../../../shared/widgets/speech_bubble.dart';
import '../../../shared/widgets/star_display.dart';
import '../../my_library/providers/library_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final region = ref.watch(selectedRegionProvider);
    final appMode = ref.watch(appModeProvider);
    final progress = ref.watch(readingProgressProvider);
    final scores = ref.watch(storyScoresProvider);

    final mascot = region != null
        ? MascotRegistry.getByRegion(region.id)
        : MascotRegistry.allMascots.first;

    final regionPacks = region != null
        ? StoryPackRegistry.getByRegion(region.id)
        : StoryPackRegistry.allPacks;

    final inProgressPack = progress.entries
        .where((e) => !e.value.completed && e.value.lastPageRead > 0)
        .toList();

    final greeting = _timeGreeting();

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
                          child: Text(
                            appMode == AppMode.child
                                ? '$greeting!'
                                : 'Welcome back',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        _ModeToggle(
                          mode: appMode,
                          onToggle: () =>
                              ref.read(appModeProvider.notifier).toggle(),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.md),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MascotAvatar(
                          mascot: mascot,
                          size: Dimensions.mascotAvatarMd,
                          borderColor: region?.color ?? AnimalColors.primary,
                        ),
                        const SizedBox(width: Dimensions.sm),
                        Expanded(
                          child: SpeechBubble(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${mascot.name} says:',
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(
                                        color: AnimalColors.textTertiary,
                                      ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  mascot.catchphrase,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            if (inProgressPack.isNotEmpty)
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
                      Text(
                        'Continue Reading',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: Dimensions.sm),
                      ...inProgressPack.map((entry) {
                        final pack = StoryPackRegistry.getById(entry.key);
                        final fraction =
                            (entry.value.lastPageRead + 1) / pack.pages.length;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: Dimensions.sm),
                          child: CartoonCard(
                            borderColor: AnimalColors.primary,
                            onTap: () => context.pushNamed(
                              'story-viewer',
                              pathParameters: {'packId': pack.id},
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pack.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: Dimensions.xs),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: fraction,
                                          backgroundColor: AnimalColors.border,
                                          color: AnimalColors.primary,
                                          minHeight: 6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: Dimensions.sm),
                                Icon(
                                  Icons.play_circle_filled_rounded,
                                  color: AnimalColors.primary,
                                  size: Dimensions.iconLg,
                                ),
                              ],
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
                  Dimensions.lg,
                  Dimensions.lg,
                  Dimensions.sm,
                ),
                child: Text(
                  'Explore Regions',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.lg,
                  ),
                  itemCount: Region.values.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: Dimensions.sm),
                  itemBuilder: (context, index) {
                    final r = Region.values[index];
                    final packCount = StoryPackRegistry.getByRegion(
                      r.id,
                    ).length;
                    final isSelected = region == r;
                    return GestureDetector(
                      onTap: () =>
                          ref.read(selectedRegionProvider.notifier).select(r),
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.all(Dimensions.sm),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AnimalColors.tint(r.color)
                              : AnimalColors.surface,
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusXl,
                          ),
                          border: Border.all(
                            color: isSelected ? r.color : AnimalColors.border,
                            width: isSelected
                                ? Dimensions.borderMd
                                : Dimensions.borderThin,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: AnimalColors.cardShadow,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(r.icon, color: r.color, size: 28),
                            const SizedBox(height: Dimensions.xs),
                            Text(
                              r.name,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? r.color
                                        : AnimalColors.textPrimary,
                                  ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '$packCount ${packCount == 1 ? "story" : "stories"}',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: AnimalColors.textTertiary,
                                    fontSize: 9,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimensions.lg,
                  Dimensions.lg,
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
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
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.78,
                  crossAxisSpacing: Dimensions.md,
                  mainAxisSpacing: Dimensions.md,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final pack = regionPacks[index];
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
                          height: 70,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                pack.safetyTheme.color.withValues(alpha: 0.25),
                                pack.safetyTheme.color.withValues(alpha: 0.08),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.radiusLg,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              pack.safetyTheme.icon,
                              size: 36,
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
                        Text(
                          pack.safetyTheme.label,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: pack.safetyTheme.color),
                        ),
                        if (score != null) ...[
                          const Spacer(),
                          StarDisplay(stars: score.stars, size: 16),
                        ],
                      ],
                    ),
                  );
                }, childCount: regionPacks.length),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: Dimensions.lg)),
            if (appMode == AppMode.educator)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.lg,
                  ),
                  child: CartoonButton(
                    label: 'View Skills Registry',
                    icon: Icons.psychology_rounded,
                    onPressed: () => context.push('/skills'),
                    color: AnimalColors.secondary,
                    expanded: true,
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: Dimensions.xxl)),
          ],
        ),
      ),
    );
  }

  String _timeGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }
}

class _ModeToggle extends StatelessWidget {
  final AppMode mode;
  final VoidCallback onToggle;

  const _ModeToggle({required this.mode, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final isChild = mode == AppMode.child;
    final color = isChild ? AnimalColors.accent : AnimalColors.secondary;
    final darkColor = isChild
        ? AnimalColors.accentDark
        : AnimalColors.secondary;

    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.md,
          vertical: Dimensions.sm,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(Dimensions.radiusRound),
          border: Border.all(color: darkColor, width: Dimensions.borderMd),
          boxShadow: [
            BoxShadow(
              color: darkColor.withValues(alpha: 0.3),
              offset: const Offset(0, 2),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isChild ? Icons.child_care : Icons.school,
              size: 18,
              color: darkColor,
            ),
            const SizedBox(width: 6),
            Text(
              isChild ? 'Child' : 'Educator',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: darkColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
