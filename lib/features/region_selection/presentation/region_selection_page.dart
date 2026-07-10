import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/regions.dart';
import '../../../core/providers/region_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/mascots/mascot_registry.dart';
import '../../../shared/widgets/cartoon_card.dart';
import '../../../shared/widgets/region_icon.dart';

class RegionSelectionPage extends ConsumerWidget {
  const RegionSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AnimalColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: Dimensions.xl),
              Container(
                width: Dimensions.iconXxl,
                height: Dimensions.iconXxl,
                decoration: BoxDecoration(
                  color: AnimalColors.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AnimalColors.primary.withValues(alpha: 0.3),
                    width: Dimensions.borderMd,
                  ),
                ),
                child: const Icon(
                  Icons.public,
                  size: Dimensions.iconLg,
                  color: AnimalColors.primary,
                ),
              ),
              const SizedBox(height: Dimensions.md),
              Text(
                'Welcome to Animalogy',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AnimalColors.textPrimary,
                ),
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
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: Dimensions.md,
                    mainAxisSpacing: Dimensions.md,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: Region.values.length,
                  itemBuilder: (context, index) {
                    final region = Region.values[index];
                    final mascot = MascotRegistry.getByRegion(region.id);
                    return _RegionGridCard(
                          region: region,
                          mascotName: mascot.name,
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
                        .scale(
                          begin: const Offset(0.9, 0.9),
                          delay: Duration(milliseconds: 100 * index),
                          duration: 400.ms,
                          curve: Curves.easeOutBack,
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

class _RegionGridCard extends StatelessWidget {
  final Region region;
  final String mascotName;
  final IconData mascotIcon;
  final VoidCallback onTap;

  const _RegionGridCard({
    required this.region,
    required this.mascotName,
    required this.mascotIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CartoonCard(
      borderColor: region.color,
      onTap: onTap,
      rotate: true,
      padding: const EdgeInsets.all(Dimensions.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RegionIcon(
            region: region,
            size: Dimensions.iconLg,
            showBackground: true,
          ),
          const SizedBox(height: Dimensions.sm),
          Text(
            region.name,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: region.color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Dimensions.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(mascotIcon, size: Dimensions.iconSm, color: region.color),
              const SizedBox(width: Dimensions.xs),
              Flexible(
                child: Text(
                  mascotName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AnimalColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.sm),
          Text(
            region.description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AnimalColors.textTertiary,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
