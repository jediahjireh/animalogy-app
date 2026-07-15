import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../../core/services/pdf_generator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../domain/models/story_pack.dart';
import 'cartoon_button.dart';

class PrintOptionsSheet extends StatelessWidget {
  final StoryPack pack;
  final String? languageCode;

  const PrintOptionsSheet({super.key, required this.pack, this.languageCode});

  static void show(
    BuildContext context,
    StoryPack pack, [
    String? languageCode,
  ]) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.radiusXl),
        ),
      ),
      builder: (_) => PrintOptionsSheet(pack: pack, languageCode: languageCode),
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
              pack.titleIn(languageCode),
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
            if (pack.questionsIn(languageCode).isNotEmpty) ...[
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
    final pdf = PdfGenerator.generateStoryPrintout(pack, languageCode);
    await Printing.layoutPdf(
      onLayout: (_) => pdf.save(),
      name: '${pack.titleIn(languageCode)} - Story',
    );
  }

  Future<void> _printActivities(BuildContext context) async {
    Navigator.pop(context);
    final pdf = PdfGenerator.generateActivitySheet(pack, languageCode);
    await Printing.layoutPdf(
      onLayout: (_) => pdf.save(),
      name: '${pack.titleIn(languageCode)} - Activities',
    );
  }

  Future<void> _printDiscussionCards(BuildContext context) async {
    Navigator.pop(context);
    final pdf = PdfGenerator.generateDiscussionCards(pack, languageCode);
    await Printing.layoutPdf(
      onLayout: (_) => pdf.save(),
      name: '${pack.titleIn(languageCode)} - Discussion Cards',
    );
  }

  Future<void> _printQuiz(BuildContext context) async {
    Navigator.pop(context);
    final pdf = PdfGenerator.generateQuizSheet(pack, languageCode);
    await Printing.layoutPdf(
      onLayout: (_) => pdf.save(),
      name: '${pack.titleIn(languageCode)} - Quiz',
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
