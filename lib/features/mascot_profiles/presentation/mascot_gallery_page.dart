import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/mascots/mascot_registry.dart';
import '../../../domain/models/mascot.dart';

class MascotGalleryPage extends StatelessWidget {
  const MascotGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mascots = MascotRegistry.allMascots;

    return Scaffold(
      appBar: AppBar(title: const Text('Meet the Mascots')),
      body: ListView.separated(
        padding: const EdgeInsets.all(Dimensions.lg),
        itemCount: mascots.length,
        separatorBuilder: (_, _) => const SizedBox(height: Dimensions.md),
        itemBuilder: (context, index) {
          final mascot = mascots[index];
          final color = AnimalColors.regionColor(mascot.regionId);

          return _MascotCard(mascot: mascot, color: color)
              .animate()
              .fadeIn(
                delay: Duration(milliseconds: 80 * index),
                duration: 400.ms,
              )
              .slideY(
                begin: 0.05,
                delay: Duration(milliseconds: 80 * index),
                duration: 400.ms,
              );
        },
      ),
    );
  }
}

class _MascotCard extends StatelessWidget {
  final Mascot mascot;
  final Color color;

  const _MascotCard({required this.mascot, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.pushNamed(
          'mascot-detail',
          pathParameters: {'mascotId': mascot.id},
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.md),
          child: Row(
            children: [
              Container(
                width: Dimensions.mascotAvatarLg,
                height: Dimensions.mascotAvatarLg,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.25),
                      color.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(mascot.icon, size: 40, color: color),
              ),
              const SizedBox(width: Dimensions.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${mascot.name} the ${mascot.species}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      mascot.personality,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '"${mascot.catchphrase}"',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: color,
                      ),
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
