import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/regions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/mascots/mascot_registry.dart';
import '../../../domain/models/mascot.dart';
import '../../../shared/widgets/badge_chip.dart';
import '../../../shared/widgets/cartoon_card.dart';

class MascotGalleryPage extends StatelessWidget {
  const MascotGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mascots = MascotRegistry.allMascots;

    return Scaffold(
      backgroundColor: AnimalColors.background,
      appBar: AppBar(
        title: Text(
          'Meet the Mascots',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.md),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: Dimensions.md,
          mainAxisSpacing: Dimensions.md,
          childAspectRatio: 0.72,
        ),
        itemCount: mascots.length,
        itemBuilder: (context, index) {
          final mascot = mascots[index];
          return _MascotGridCard(mascot: mascot)
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: 80 * index),
                duration: 400.ms,
              )
              .scale(
                begin: const Offset(0.9, 0.9),
                delay: Duration(milliseconds: 80 * index),
                duration: 400.ms,
                curve: Curves.easeOutBack,
              );
        },
      ),
    );
  }
}

class _MascotGridCard extends StatelessWidget {
  final Mascot mascot;

  const _MascotGridCard({required this.mascot});

  @override
  Widget build(BuildContext context) {
    final color = AnimalColors.regionColor(mascot.regionId);
    final region = Region.fromId(mascot.regionId);

    return CartoonCard(
      borderColor: color,
      rotate: true,
      onTap: () => context.pushNamed(
        'mascot-detail',
        pathParameters: {'mascotId': mascot.id},
      ),
      padding: const EdgeInsets.all(Dimensions.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Dimensions.mascotAvatarMd,
            height: Dimensions.mascotAvatarMd,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.25),
                  color.withValues(alpha: 0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: color.withValues(alpha: 0.4),
                width: Dimensions.borderMd,
              ),
            ),
            child: Icon(mascot.icon, size: 30, color: color),
          ),
          const SizedBox(height: Dimensions.sm),
          Text(
            mascot.name,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: AnimalColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'The ${mascot.species}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AnimalColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Dimensions.sm),
          if (region != null)
            BadgeChip(
              label: region.name,
              icon: region.icon,
              color: color,
              selected: true,
            ),
          const SizedBox(height: Dimensions.sm),
          Flexible(
            child: Text(
              '"${mascot.catchphrase}"',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: color,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
