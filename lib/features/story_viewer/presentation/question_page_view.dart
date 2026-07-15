import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/utils/haptic_utils.dart';
import '../../../domain/models/comprehension_question.dart';
import '../../../shared/widgets/cartoon_button.dart';
import '../../../shared/widgets/speech_bubble.dart';

class QuestionPageView extends StatefulWidget {
  final ComprehensionQuestion question;
  final String mascotName;
  final String mascotImageUrl;
  final VoidCallback onAnswered;
  final void Function(bool correct) onResult;

  const QuestionPageView({
    super.key,
    required this.question,
    required this.mascotName,
    this.mascotImageUrl = '',
    required this.onAnswered,
    required this.onResult,
  });

  @override
  State<QuestionPageView> createState() => _QuestionPageViewState();
}

class _QuestionPageViewState extends State<QuestionPageView> {
  int? _selectedIndex;
  bool _answered = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Dimensions.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.mascotAvatarSm,
                height: Dimensions.mascotAvatarSm,
                decoration: BoxDecoration(
                  color: AnimalColors.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AnimalColors.primary,
                    width: Dimensions.borderMd,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: widget.mascotImageUrl.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(4),
                        child: Image.network(
                          widget.mascotImageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.pets,
                                color: AnimalColors.primary,
                                size: 22,
                              ),
                        ),
                      )
                    : const Icon(
                        Icons.pets,
                        color: AnimalColors.primary,
                        size: 22,
                      ),
              ),
              const SizedBox(width: Dimensions.sm),
              Expanded(
                child: SpeechBubble(
                  child: Text(
                    widget.question.questionText,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.xl),
          ...List.generate(widget.question.options.length, (i) {
            final isSelected = _selectedIndex == i;
            final isCorrect = i == widget.question.correctIndex;

            Color? color;
            if (_answered && isSelected) {
              color = isCorrect ? AnimalColors.success : AnimalColors.error;
            } else if (_answered && isCorrect) {
              color = AnimalColors.success;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.md),
              child: _AnswerOption(
                text: widget.question.options[i],
                index: i,
                color: color,
                enabled: !_answered,
                onTap: () => _handleAnswer(i),
              ),
            );
          }),
          if (_answered) ...[
            const SizedBox(height: Dimensions.md),
            _FeedbackCard(
              correct: _selectedIndex == widget.question.correctIndex,
              explanation: widget.question.explanation,
              encouragement: widget.question.mascotEncouragement,
              mascotName: widget.mascotName,
            ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0),
            const SizedBox(height: Dimensions.lg),
            CartoonButton(
              label: 'Continue',
              icon: Icons.arrow_forward_rounded,
              onPressed: widget.onAnswered,
              expanded: true,
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
          ],
        ],
      ),
    );
  }

  void _handleAnswer(int index) {
    if (_answered) return;
    setState(() {
      _selectedIndex = index;
      _answered = true;
    });
    final correct = index == widget.question.correctIndex;
    if (correct) {
      HapticUtils.success();
    } else {
      HapticUtils.error();
    }
    widget.onResult(correct);
  }
}

class _AnswerOption extends StatelessWidget {
  final String text;
  final int index;
  final Color? color;
  final bool enabled;
  final VoidCallback onTap;

  const _AnswerOption({
    required this.text,
    required this.index,
    this.color,
    required this.enabled,
    required this.onTap,
  });

  static const _labels = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final borderColor = color ?? AnimalColors.border;
    final bgColor = color?.withValues(alpha: 0.1) ?? AnimalColors.surface;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(Dimensions.md),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusXl),
          border: Border.all(
            color: borderColor,
            width: color != null ? Dimensions.borderThick : Dimensions.borderMd,
          ),
          boxShadow: [
            if (color == null)
              const BoxShadow(
                color: AnimalColors.cardShadow,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color ?? AnimalColors.surfaceVariant,
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor,
                  width: Dimensions.borderThin,
                ),
              ),
              child: Center(
                child: Text(
                  _labels[index],
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: color != null
                        ? AnimalColors.textOnPrimary
                        : AnimalColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(width: Dimensions.md),
            Expanded(
              child: Text(
                text,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            if (color != null)
              Icon(
                color == AnimalColors.success
                    ? Icons.check_circle_rounded
                    : Icons.cancel_rounded,
                color: color,
                size: Dimensions.iconMd,
              ),
          ],
        ),
      ),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  final bool correct;
  final String explanation;
  final String encouragement;
  final String mascotName;

  const _FeedbackCard({
    required this.correct,
    required this.explanation,
    required this.encouragement,
    required this.mascotName,
  });

  @override
  Widget build(BuildContext context) {
    final color = correct ? AnimalColors.success : AnimalColors.warning;

    return Container(
      padding: const EdgeInsets.all(Dimensions.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Dimensions.radiusXl),
        border: Border.all(color: color, width: Dimensions.borderMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                correct
                    ? Icons.celebration_rounded
                    : Icons.info_outline_rounded,
                color: color,
              ),
              const SizedBox(width: Dimensions.sm),
              Text(
                correct ? 'Correct!' : 'Not quite!',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.sm),
          Text(
            explanation,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AnimalColors.textPrimary),
          ),
          if (correct) ...[
            const SizedBox(height: Dimensions.sm),
            Text(
              '$mascotName says: "$encouragement"',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: AnimalColors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
