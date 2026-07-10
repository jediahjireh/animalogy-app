import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/story_packs/story_pack_registry.dart';
import '../../../shared/widgets/cartoon_button.dart';
import '../../../shared/widgets/print_options_sheet.dart';

class EducatorGuidePage extends StatelessWidget {
  final String packId;

  const EducatorGuidePage({super.key, required this.packId});

  @override
  Widget build(BuildContext context) {
    final pack = StoryPackRegistry.getById(packId);
    final guide = pack.educatorGuide;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Educator Guide'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print_rounded),
            tooltip: 'Printable Resources',
            onPressed: () {
              final pack = StoryPackRegistry.getById(packId);
              PrintOptionsSheet.show(context, pack);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Dimensions.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Dimensions.md),
              decoration: BoxDecoration(
                color: AnimalColors.primaryLight,
                borderRadius: BorderRadius.circular(Dimensions.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pack.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Theme: ${pack.safetyTheme.label}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: pack.safetyTheme.color,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.lg),
            _SectionHeader(title: 'Learning Objectives', icon: Icons.flag),
            const SizedBox(height: Dimensions.sm),
            ...guide.learningObjectives.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AnimalColors.secondary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${entry.key + 1}',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: AnimalColors.secondary),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.sm),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Dimensions.lg),
            _SectionHeader(
              title: 'Discussion Prompts',
              icon: Icons.chat_bubble_outline,
            ),
            const SizedBox(height: Dimensions.sm),
            ...guide.discussionPrompts.map(
              (prompt) => Card(
                margin: const EdgeInsets.only(bottom: Dimensions.sm),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.md,
                  ),
                  title: Text(
                    prompt.question,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    'Best for ages ${prompt.targetAge.label}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        Dimensions.md,
                        0,
                        Dimensions.md,
                        Dimensions.md,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(Dimensions.md),
                        decoration: BoxDecoration(
                          color: AnimalColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(
                            Dimensions.radiusSm,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Guidance for facilitator:',
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(color: AnimalColors.primary),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              prompt.guidanceNote,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Dimensions.lg),
            _SectionHeader(title: 'Activities', icon: Icons.extension),
            const SizedBox(height: Dimensions.sm),
            ...guide.activities.map(
              (activity) => Card(
                margin: const EdgeInsets.only(bottom: Dimensions.sm),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              activity.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AnimalColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(
                                Dimensions.radiusRound,
                              ),
                            ),
                            child: Text(
                              'Ages ${activity.targetAge.label}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimensions.sm),
                      Text(
                        activity.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: Dimensions.sm),
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: AnimalColors.textTertiary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${activity.durationMinutes} minutes',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: AnimalColors.textTertiary),
                          ),
                        ],
                      ),
                      if (activity.materials.isNotEmpty) ...[
                        const SizedBox(height: Dimensions.sm),
                        Text(
                          'Materials needed:',
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(color: AnimalColors.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        ...activity.materials.map(
                          (m) => Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 6,
                                color: AnimalColors.textTertiary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                m,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: Dimensions.lg),
            _SectionHeader(title: 'Cultural Context', icon: Icons.public),
            const SizedBox(height: Dimensions.sm),
            Text(
              guide.culturalContext,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: Dimensions.lg),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Dimensions.md),
              decoration: BoxDecoration(
                color: AnimalColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Dimensions.radiusMd),
                border: Border.all(
                  color: AnimalColors.secondary.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, size: 20, color: AnimalColors.secondary),
                      const SizedBox(width: 8),
                      Text(
                        'Key Safety Takeaway',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AnimalColors.secondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.sm),
                  Text(
                    guide.safetyTakeaway,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimensions.lg),
            CartoonButton(
              label: 'Print Resources',
              icon: Icons.print_rounded,
              onPressed: () => PrintOptionsSheet.show(context, pack),
              color: AnimalColors.info,
              expanded: true,
            ),
            const SizedBox(height: Dimensions.xxl),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: AnimalColors.primary),
        const SizedBox(width: 8),
        Text(title, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
