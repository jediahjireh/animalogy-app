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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text(
          appMode == AppMode.child ? 'What I Learned' : 'Skills Registry',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Dimensions.lg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AnimalColors.primary.withValues(alpha: 0.15),
                    AnimalColors.accent.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(Dimensions.radiusLg),
              ),
              child: Column(
                children: [
                  Text(
                    '$completedCount / ${skills.length}',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AnimalColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    appMode == AppMode.child
                        ? 'Skills Unlocked'
                        : 'Skills Completed',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.lg),
            ...skills.map((skill) {
              final completionFraction = _skillCompletion(skill, progress);
              final isComplete = completionFraction >= 1.0;

              return Card(
                margin: const EdgeInsets.only(bottom: Dimensions.md),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.md),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: completionFraction,
                              strokeWidth: 4,
                              backgroundColor: AnimalColors.border,
                              color: isComplete
                                  ? AnimalColors.success
                                  : AnimalColors.primary,
                            ),
                            Icon(
                              skill.icon,
                              size: 22,
                              color: isComplete
                                  ? AnimalColors.success
                                  : AnimalColors.primary,
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
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              skill.description,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: Dimensions.sm),
                            ...skill.relatedPackIds.map((packId) {
                              final pack = StoryPackRegistry.getById(packId);
                              final done = progress[packId]?.completed == true;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: GestureDetector(
                                  onTap: () => context.pushNamed(
                                    'story-pack-detail',
                                    pathParameters: {'packId': packId},
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
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                              ),
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
