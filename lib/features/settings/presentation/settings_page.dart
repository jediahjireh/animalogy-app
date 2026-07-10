import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/regions.dart';
import '../../../core/providers/app_mode_provider.dart';
import '../../../core/providers/region_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../domain/models/app_mode.dart';
import '../../../shared/widgets/cartoon_card.dart';
import '../../../shared/widgets/region_icon.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appMode = ref.watch(appModeProvider);
    final region = ref.watch(selectedRegionProvider);
    final isEducator = appMode == AppMode.educator;

    return Scaffold(
      backgroundColor: AnimalColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Settings',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Dimensions.md),
        children: [
          CartoonCard(
            borderColor: isEducator
                ? AnimalColors.secondary
                : AnimalColors.accent,
            child: Row(
              children: [
                Container(
                  width: Dimensions.mascotAvatarSm,
                  height: Dimensions.mascotAvatarSm,
                  decoration: BoxDecoration(
                    color:
                        (isEducator
                                ? AnimalColors.secondary
                                : AnimalColors.accent)
                            .withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          (isEducator
                                  ? AnimalColors.secondary
                                  : AnimalColors.accent)
                              .withValues(alpha: 0.3),
                      width: Dimensions.borderThin,
                    ),
                  ),
                  child: Icon(
                    isEducator ? Icons.school : Icons.child_care,
                    color: isEducator
                        ? AnimalColors.secondary
                        : AnimalColors.accent,
                    size: Dimensions.iconMd,
                  ),
                ),
                const SizedBox(width: Dimensions.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Educator Mode',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isEducator
                            ? 'Full guides, activities, and discussion prompts visible'
                            : 'Simplified view optimized for children',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AnimalColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: isEducator,
                  activeTrackColor: AnimalColors.secondary.withValues(
                    alpha: 0.5,
                  ),
                  activeThumbColor: AnimalColors.secondary,
                  onChanged: (_) => ref.read(appModeProvider.notifier).toggle(),
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.md),
          CartoonCard(
            borderColor: region?.color ?? AnimalColors.border,
            onTap: () => _showRegionPicker(context, ref, region),
            child: Row(
              children: [
                if (region != null)
                  RegionIcon(
                    region: region,
                    size: Dimensions.iconMd,
                    showBackground: true,
                  )
                else
                  Container(
                    width: Dimensions.mascotAvatarSm,
                    height: Dimensions.mascotAvatarSm,
                    decoration: BoxDecoration(
                      color: AnimalColors.primaryLight,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AnimalColors.border,
                        width: Dimensions.borderThin,
                      ),
                    ),
                    child: const Icon(
                      Icons.public,
                      color: AnimalColors.primary,
                      size: Dimensions.iconMd,
                    ),
                  ),
                const SizedBox(width: Dimensions.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Region',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        region?.name ?? 'Not selected',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AnimalColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: AnimalColors.textTertiary,
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.xl),
          CartoonCard(
            borderColor: AnimalColors.border,
            padding: const EdgeInsets.all(Dimensions.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AnimalColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(
                          Dimensions.radiusSm,
                        ),
                        border: Border.all(
                          color: AnimalColors.primary.withValues(alpha: 0.3),
                          width: Dimensions.borderThin,
                        ),
                      ),
                      child: const Icon(
                        Icons.info_outline,
                        size: 18,
                        color: AnimalColors.primary,
                      ),
                    ),
                    const SizedBox(width: Dimensions.sm),
                    Text(
                      'About Animalogy',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.md),
                Text(
                  'Animalogy teaches children about safety, trust, and '
                  'digital awareness through culturally-relevant animal '
                  'stories. Each story uses real animal behaviours to help '
                  'kids understand complex social situations in a way that '
                  'feels familiar and engaging.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AnimalColors.textSecondary,
                  ),
                ),
                const SizedBox(height: Dimensions.md),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.md,
                    vertical: Dimensions.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AnimalColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(Dimensions.radiusRound),
                    border: Border.all(
                      color: AnimalColors.border,
                      width: Dimensions.borderThin,
                    ),
                  ),
                  child: Text(
                    'Version 1.0.0',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AnimalColors.textTertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showRegionPicker(BuildContext context, WidgetRef ref, Region? current) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AnimalColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.radiusXl),
        ),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: Dimensions.sm),
              decoration: BoxDecoration(
                color: AnimalColors.border,
                borderRadius: BorderRadius.circular(Dimensions.radiusRound),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimensions.md),
              child: Text(
                'Select Region',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            ...Region.values.map(
              (r) => Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: Dimensions.md,
                  vertical: Dimensions.xs,
                ),
                decoration: BoxDecoration(
                  color: r == current
                      ? r.color.withValues(alpha: 0.1)
                      : AnimalColors.surface,
                  borderRadius: BorderRadius.circular(Dimensions.radiusMd),
                  border: Border.all(
                    color: r == current ? r.color : AnimalColors.border,
                    width: r == current
                        ? Dimensions.borderMd
                        : Dimensions.borderThin,
                  ),
                ),
                child: ListTile(
                  leading: RegionIcon(
                    region: r,
                    size: Dimensions.iconMd,
                    showBackground: true,
                  ),
                  title: Text(
                    r.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: r == current
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: r == current ? r.color : AnimalColors.textPrimary,
                    ),
                  ),
                  trailing: r == current
                      ? Icon(Icons.check_circle, color: r.color)
                      : null,
                  onTap: () {
                    ref.read(selectedRegionProvider.notifier).select(r);
                    Navigator.pop(ctx);
                  },
                ),
              ),
            ),
            const SizedBox(height: Dimensions.md),
          ],
        ),
      ),
    );
  }
}
