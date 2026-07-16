import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/l10n/ui_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/utils/haptic_utils.dart';
import '../../../shared/widgets/cartoon_button.dart';
import '../../../shared/widgets/speech_bubble.dart';
import '../../../shared/widgets/star_display.dart';

class StoryCompleteOverlay extends StatefulWidget {
  final String? languageCode;
  final String mascotName;
  final String mascotImageUrl;
  final int stars;
  final int correctAnswers;
  final int totalQuestions;
  final VoidCallback onReadAgain;
  final VoidCallback onDone;

  const StoryCompleteOverlay({
    super.key,
    this.languageCode,
    required this.mascotName,
    this.mascotImageUrl = '',
    required this.stars,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.onReadAgain,
    required this.onDone,
  });

  @override
  State<StoryCompleteOverlay> createState() => _StoryCompleteOverlayState();
}

class _StoryCompleteOverlayState extends State<StoryCompleteOverlay> {
  @override
  void initState() {
    super.initState();
    HapticUtils.success();
  }

  @override
  Widget build(BuildContext context) {
    final strings = UIStrings.of(widget.languageCode);
    final message = strings.starMessage(widget.stars);

    return Container(
      color: AnimalColors.background.withValues(alpha: 0.95),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimensions.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                (widget.mascotImageUrl.isNotEmpty
                        ? Container(
                            width: Dimensions.mascotAvatarLg,
                            height: Dimensions.mascotAvatarLg,
                            decoration: BoxDecoration(
                              color: AnimalColors.accent.withValues(
                                alpha: 0.15,
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AnimalColors.accent.withValues(
                                  alpha: 0.4,
                                ),
                                width: Dimensions.borderThick,
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.network(
                                widget.mascotImageUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.auto_awesome,
                                      size: Dimensions.iconXxl,
                                      color: AnimalColors.accent,
                                    ),
                              ),
                            ),
                          )
                        : const Icon(
                                Icons.auto_awesome,
                                size: Dimensions.iconXxl,
                                color: AnimalColors.accent,
                              )
                              as Widget)
                    .animate()
                    .scale(
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1, 1),
                      duration: 500.ms,
                      curve: Curves.elasticOut,
                    ),
                const SizedBox(height: Dimensions.lg),
                Text(
                  strings.storyComplete,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AnimalColors.primary,
                  ),
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                const SizedBox(height: Dimensions.lg),
                StarDisplay(stars: widget.stars, size: 48)
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 400.ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                    ),
                const SizedBox(height: Dimensions.md),
                Text(
                  '${widget.correctAnswers} / ${widget.totalQuestions} ${strings.correctLabel}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AnimalColors.textSecondary,
                  ),
                ).animate().fadeIn(delay: 500.ms, duration: 300.ms),
                const SizedBox(height: Dimensions.xl),
                SpeechBubble(
                  tailDirection: BubbleTailDirection.bottomCenter,
                  child: Column(
                    children: [
                      Text(
                        '${widget.mascotName} ${strings.says}',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(color: AnimalColors.textTertiary),
                      ),
                      const SizedBox(height: Dimensions.xs),
                      Text(
                        message,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
                const SizedBox(height: Dimensions.xl),
                CartoonButton(
                  label: strings.backToStories,
                  icon: Icons.menu_book_rounded,
                  onPressed: widget.onDone,
                  expanded: true,
                ).animate().fadeIn(delay: 800.ms, duration: 300.ms),
                const SizedBox(height: Dimensions.md),
                CartoonButton(
                  label: strings.readAgain,
                  icon: Icons.replay_rounded,
                  onPressed: widget.onReadAgain,
                  color: AnimalColors.secondary,
                  expanded: true,
                ).animate().fadeIn(delay: 900.ms, duration: 300.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
