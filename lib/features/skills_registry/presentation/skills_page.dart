import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/app_mode_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/skills/skills_registry.dart';
import '../../../data/story_packs/story_pack_registry.dart';
import '../../../domain/models/app_mode.dart';
import '../../../domain/models/reading_progress.dart';
import '../../../domain/models/skill.dart';
import '../../../shared/widgets/cartoon_card.dart';
import '../../my_library/providers/library_providers.dart';

class SkillsPage extends ConsumerWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skills = SkillsRegistry.allSkills;
    final progress = ref.watch(readingProgressProvider);
    final appMode = ref.watch(appModeProvider);

    final completedCount = skills.where((s) {
      return s.relatedPackIds.every((id) => progress[id]?.completed == true);
    }).length;

    return Scaffold(
      backgroundColor: AnimalColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          appMode == AppMode.child ? 'What I Learned' : 'Skills Registry',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CartoonCard(
              borderColor: AnimalColors.primary,
              padding: const EdgeInsets.all(Dimensions.lg),
              child: Row(
                children: [
                  Container(
                    width: Dimensions.mascotAvatarMd,
                    height: Dimensions.mascotAvatarMd,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AnimalColors.primary.withValues(alpha: 0.2),
                          AnimalColors.accent.withValues(alpha: 0.15),
                        ],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AnimalColors.primary.withValues(alpha: 0.3),
                        width: Dimensions.borderMd,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$completedCount',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: AnimalColors.primary,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Dimensions.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$completedCount / ${skills.length}',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: AnimalColors.primary,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        Text(
                          appMode == AppMode.child
                              ? 'Skills Unlocked'
                              : 'Skills Completed',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AnimalColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.emoji_events,
                    size: Dimensions.iconLg,
                    color: AnimalColors.accent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.lg),
            ...skills.map((skill) {
              final completionFraction = _skillCompletion(skill, progress);
              final isComplete = completionFraction >= 1.0;
              final skillColor = isComplete
                  ? AnimalColors.success
                  : AnimalColors.primary;

              return Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.md),
                child: CartoonCard(
                  borderColor: skillColor.withValues(alpha: 0.5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Dimensions.iconXl,
                        height: Dimensions.iconXl,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: Dimensions.iconXl,
                              height: Dimensions.iconXl,
                              child: CircularProgressIndicator(
                                value: completionFraction,
                                strokeWidth: Dimensions.borderThick,
                                strokeCap: StrokeCap.round,
                                backgroundColor: AnimalColors.border,
                                color: skillColor,
                              ),
                            ),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: skillColor.withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                skill.icon,
                                size: Dimensions.iconSm,
                                color: skillColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: Dimensions.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              skill.name,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              skill.description,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: AnimalColors.textSecondary),
                            ),
                            const SizedBox(height: Dimensions.sm),
                            ...skill.relatedPackIds.map((packId) {
                              final pack = StoryPackRegistry.getById(packId);
                              final done = progress[packId]?.completed == true;
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: Dimensions.xs,
                                ),
                                child: GestureDetector(
                                  onTap: () => context.pushNamed(
                                    'story-pack-detail',
                                    pathParameters: {'packId': packId},
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.sm,
                                      vertical: Dimensions.xs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: done
                                          ? AnimalColors.success.withValues(
                                              alpha: 0.08,
                                            )
                                          : AnimalColors.surfaceVariant,
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radiusSm,
                                      ),
                                      border: Border.all(
                                        color: done
                                            ? AnimalColors.success.withValues(
                                                alpha: 0.3,
                                              )
                                            : AnimalColors.border,
                                        width: Dimensions.borderThin,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          done
                                              ? Icons.check_circle
                                              : Icons.circle_outlined,
                                          size: 16,
                                          color: done
                                              ? AnimalColors.success
                                              : AnimalColors.textTertiary,
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            pack.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(
                                                  color: done
                                                      ? AnimalColors.success
                                                      : AnimalColors
                                                            .textSecondary,
                                                  decoration: done
                                                      ? TextDecoration
                                                            .lineThrough
                                                      : null,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.chevron_right,
                                          size: 16,
                                          color: AnimalColors.textTertiary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  double _skillCompletion(Skill skill, Map<String, ReadingProgress> progress) {
    if (skill.relatedPackIds.isEmpty) return 0;
    final completed = skill.relatedPackIds
        .where((id) => progress[id]?.completed == true)
        .length;
    return completed / skill.relatedPackIds.length;
  }
}
