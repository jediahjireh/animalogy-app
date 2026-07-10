import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/regions.dart';
import '../../../core/providers/region_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/mascots/mascot_registry.dart';

class RegionSelectionPage extends ConsumerWidget {
  const RegionSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: Dimensions.xl),
              Icon(Icons.public, size: 64, color: AnimalColors.primary),
              const SizedBox(height: Dimensions.md),
              Text(
                'Welcome to Animalogy',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.sm),
              Text(
                'Choose your region to meet your local animal guide',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AnimalColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.xl),
              Expanded(
                child: ListView.separated(
                  itemCount: Region.values.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: Dimensions.md),
                  itemBuilder: (context, index) {
                    final region = Region.values[index];
                    final mascot = MascotRegistry.getByRegion(region.id);
                    return _RegionTile(
                          region: region,
                          mascotName: mascot.name,
                          mascotSpecies: mascot.species,
                          mascotIcon: mascot.icon,
                          onTap: () async {
                            await ref
                                .read(selectedRegionProvider.notifier)
                                .select(region);
                            if (context.mounted) context.go('/');
                          },
                        )
                        .animate()
                        .fadeIn(
                          delay: Duration(milliseconds: 100 * index),
                          duration: 400.ms,
                        )
                        .slideX(
                          begin: 0.1,
                          delay: Duration(milliseconds: 100 * index),
                          duration: 400.ms,
                        );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegionTile extends StatelessWidget {
  final Region region;
  final String mascotName;
  final String mascotSpecies;
  final IconData mascotIcon;
  final VoidCallback onTap;

  const _RegionTile({
    required this.region,
    required this.mascotName,
    required this.mascotSpecies,
    required this.mascotIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.md),
          child: Row(
            children: [
              Container(
                width: Dimensions.mascotAvatarMd,
                height: Dimensions.mascotAvatarMd,
                decoration: BoxDecoration(
                  color: region.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(Dimensions.radiusMd),
                ),
                child: Icon(mascotIcon, color: region.color, size: 32),
              ),
              const SizedBox(width: Dimensions.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${region.emoji} ${region.name}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Guide: $mascotName the $mascotSpecies',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      region.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AnimalColors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}
