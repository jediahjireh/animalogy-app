import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../../core/services/pdf_generator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../domain/models/story_pack.dart';
import 'cartoon_button.dart';

class PrintOptionsSheet extends StatelessWidget {
  final StoryPack pack;

  const PrintOptionsSheet({super.key, required this.pack});

  static void show(BuildContext context, StoryPack pack) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.radiusXl),
        ),
      ),
      builder: (_) => PrintOptionsSheet(pack: pack),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AnimalColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: Dimensions.md),
            Text(
              'Printable Resources',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimensions.xs),
            Text(
              pack.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AnimalColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimensions.lg),
            _PrintOption(
              icon: Icons.auto_stories_rounded,
              label: 'Story Printout',
              subtitle: 'Full story with learning cues',
              color: AnimalColors.primary,
              onTap: () => _printStory(context),
            ),
            const SizedBox(height: Dimensions.sm),
            _PrintOption(
              icon: Icons.extension_rounded,
              label: 'Activity Sheet',
              subtitle: 'Hands-on activities and materials list',
              color: AnimalColors.success,
              onTap: () => _printActivities(context),
            ),
            const SizedBox(height: Dimensions.sm),
            _PrintOption(
              icon: Icons.forum_rounded,
              label: 'Discussion Cards',
              subtitle: 'Cut-out prompt cards for group talk',
              color: AnimalColors.secondary,
              onTap: () => _printDiscussionCards(context),
            ),
            if (pack.questions.isNotEmpty) ...[
              const SizedBox(height: Dimensions.sm),
              _PrintOption(
                icon: Icons.quiz_rounded,
                label: 'Quiz Sheet',
                subtitle: 'Questions with answer key',
                color: AnimalColors.accent,
                onTap: () => _printQuiz(context),
              ),
            ],
            const SizedBox(height: Dimensions.md),
          ],
        ),
      ),
    );
  }

  Future<void> _printStory(BuildContext context) async {
    Navigator.pop(context);
    final pdf = PdfGenerator.generateStoryPrintout(pack);
    await Printing.layoutPdf(
      onLayout: (_) => pdf.save(),
      name: '${pack.title} - Story',
    );
  }

  Future<void> _printActivities(BuildContext context) async {
    Navigator.pop(context);
    final pdf = PdfGenerator.generateActivitySheet(pack);
    await Printing.layoutPdf(
      onLayout: (_) => pdf.save(),
      name: '${pack.title} - Activities',
    );
  }

  Future<void> _printDiscussionCards(BuildContext context) async {
    Navigator.pop(context);
    final pdf = PdfGenerator.generateDiscussionCards(pack);
    await Printing.layoutPdf(
      onLayout: (_) => pdf.save(),
      name: '${pack.title} - Discussion Cards',
    );
  }

  Future<void> _printQuiz(BuildContext context) async {
    Navigator.pop(context);
    final pdf = PdfGenerator.generateQuizSheet(pack);
    await Printing.layoutPdf(
      onLayout: (_) => pdf.save(),
      name: '${pack.title} - Quiz',
    );
  }
}

class _PrintOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _PrintOption({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CartoonButton(
      label: label,
      icon: icon,
      color: color,
      expanded: true,
      onPressed: onTap,
    );
  }
}
