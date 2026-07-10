import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/regions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/mascots/mascot_registry.dart';
import '../../../data/story_packs/story_pack_registry.dart';

class MascotDetailPage extends StatelessWidget {
  final String mascotId;

  const MascotDetailPage({super.key, required this.mascotId});

  @override
  Widget build(BuildContext context) {
    final mascot = MascotRegistry.getById(mascotId);
    final region = Region.fromId(mascot.regionId);
    final color = AnimalColors.regionColor(mascot.regionId);
    final relatedPacks = StoryPackRegistry.allPacks
        .where((p) => p.mascotId == mascotId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Dimensions.mascotAvatarXl,
              height: Dimensions.mascotAvatarXl,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.3),
                    color.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(mascot.icon, size: 64, color: color),
            ),
            const SizedBox(height: Dimensions.md),
            Text(mascot.name, style: Theme.of(context).textTheme.headlineLarge),
            Text(
              'The ${mascot.species}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AnimalColors.textSecondary,
              ),
            ),
            if (region != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${region.emoji} ${region.name}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            const SizedBox(height: Dimensions.md),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.md,
                vertical: Dimensions.sm,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Dimensions.radiusRound),
              ),
              child: Text(
                '"${mascot.catchphrase}"',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: color,
                ),
              ),
            ),
            const SizedBox(height: Dimensions.xl),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoSection(
                    title: 'Personality',
                    content: mascot.personality,
                    icon: Icons.favorite_outline,
                    color: color,
                  ),
                  const SizedBox(height: Dimensions.lg),
                  _InfoSection(
                    title: 'Story',
                    content: mascot.bio,
                    icon: Icons.auto_stories_outlined,
                    color: color,
                  ),
                  const SizedBox(height: Dimensions.lg),
                  _InfoSection(
                    title: 'Safety Role',
                    content: mascot.safetyRole,
                    icon: Icons.shield_outlined,
                    color: color,
                  ),
                  if (relatedPacks.isNotEmpty) ...[
                    const SizedBox(height: Dimensions.xl),
                    Text(
                      '${mascot.name}\'s Stories',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: Dimensions.sm),
                    ...relatedPacks.map(
                      (pack) => Card(
                        margin: const EdgeInsets.only(bottom: Dimensions.sm),
                        child: ListTile(
                          leading: Icon(
                            pack.safetyTheme.icon,
                            color: pack.safetyTheme.color,
                          ),
                          title: Text(pack.title),
                          subtitle: Text(pack.safetyTheme.label),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.pushNamed(
                            'story-pack-detail',
                            pathParameters: {'packId': pack.id},
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: Dimensions.xxl),
          ],
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;

  const _InfoSection({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: color),
            ),
          ],
        ),
        const SizedBox(height: Dimensions.sm),
        Text(content, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
