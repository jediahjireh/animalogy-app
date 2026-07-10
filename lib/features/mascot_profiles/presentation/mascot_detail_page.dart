import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/regions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/mascots/mascot_registry.dart';
import '../../../data/story_packs/story_pack_registry.dart';
import '../../../shared/widgets/badge_chip.dart';
import '../../../shared/widgets/cartoon_card.dart';
import '../../../shared/widgets/speech_bubble.dart';

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
      backgroundColor: AnimalColors.background,
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
                    color.withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withValues(alpha: 0.4),
                  width: Dimensions.borderThick,
                ),
              ),
              child: Icon(mascot.icon, size: 64, color: color),
            ),
            const SizedBox(height: Dimensions.md),
            Text(
              mascot.name,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: AnimalColors.textPrimary,
              ),
            ),
            Text(
              'The ${mascot.species}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AnimalColors.textSecondary,
              ),
            ),
            if (region != null)
              Padding(
                padding: const EdgeInsets.only(top: Dimensions.sm),
                child: BadgeChip(
                  label: region.name,
                  icon: region.icon,
                  color: color,
                  selected: true,
                ),
              ),
            const SizedBox(height: Dimensions.lg),
            SpeechBubble(
              tailDirection: BubbleTailDirection.bottomCenter,
              borderColor: color,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.format_quote, size: 20, color: color),
                  const SizedBox(width: Dimensions.sm),
                  Flexible(
                    child: Text(
                      mascot.catchphrase,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.lg),
            _buildPersonalityChips(context, mascot.personality, color),
            const SizedBox(height: Dimensions.lg),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BioSection(
                    title: 'Story',
                    content: mascot.bio,
                    icon: Icons.auto_stories_outlined,
                    color: color,
                  ),
                  const SizedBox(height: Dimensions.lg),
                  _BioSection(
                    title: 'Safety Role',
                    content: mascot.safetyRole,
                    icon: Icons.shield_outlined,
                    color: color,
                  ),
                  if (relatedPacks.isNotEmpty) ...[
                    const SizedBox(height: Dimensions.xl),
                    Text(
                      '${mascot.name}\'s Stories',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AnimalColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: Dimensions.sm),
                    ...relatedPacks.map(
                      (pack) => Padding(
                        padding: const EdgeInsets.only(bottom: Dimensions.sm),
                        child: CartoonCard(
                          borderColor: pack.safetyTheme.color,
                          onTap: () => context.pushNamed(
                            'story-pack-detail',
                            pathParameters: {'packId': pack.id},
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: pack.safetyTheme.color.withValues(
                                    alpha: 0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    Dimensions.radiusMd,
                                  ),
                                  border: Border.all(
                                    color: pack.safetyTheme.color.withValues(
                                      alpha: 0.3,
                                    ),
                                    width: Dimensions.borderThin,
                                  ),
                                ),
                                child: Icon(
                                  pack.safetyTheme.icon,
                                  color: pack.safetyTheme.color,
                                  size: Dimensions.iconSm,
                                ),
                              ),
                              const SizedBox(width: Dimensions.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pack.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    Text(
                                      pack.safetyTheme.label,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
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

  Widget _buildPersonalityChips(
    BuildContext context,
    String personality,
    Color color,
  ) {
    final traits = personality.split(',').map((t) => t.trim()).toList();
    if (traits.length <= 1) {
      return BadgeChip(
        label: personality,
        icon: Icons.favorite,
        color: color,
        selected: true,
      );
    }
    return Wrap(
      spacing: Dimensions.sm,
      runSpacing: Dimensions.sm,
      alignment: WrapAlignment.center,
      children: traits.map((trait) {
        return BadgeChip(
          label: trait,
          icon: Icons.favorite,
          color: color,
          selected: true,
        );
      }).toList(),
    );
  }
}

class _BioSection extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;

  const _BioSection({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CartoonCard(
      borderColor: color.withValues(alpha: 0.4),
      padding: const EdgeInsets.all(Dimensions.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(Dimensions.radiusSm),
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: Dimensions.borderThin,
                  ),
                ),
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(width: Dimensions.sm),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.sm),
          Text(content, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
