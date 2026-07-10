import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/providers/app_mode_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/mascots/mascot_registry.dart';
import '../../../data/story_packs/story_pack_registry.dart';
import '../../../domain/models/app_mode.dart';
import '../../../domain/models/story_pack.dart';
import '../../../domain/models/story_page.dart';
import '../../../domain/models/story_score.dart';
import '../../../shared/widgets/cartoon_button.dart';
import '../../my_library/providers/library_providers.dart';
import 'question_page_view.dart';
import 'story_complete_overlay.dart';

enum _PageType { story, question }

class _InterleavedPage {
  final _PageType type;
  final int index;
  const _InterleavedPage(this.type, this.index);
}

class StoryViewerPage extends ConsumerStatefulWidget {
  final String packId;

  const StoryViewerPage({super.key, required this.packId});

  @override
  ConsumerState<StoryViewerPage> createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends ConsumerState<StoryViewerPage> {
  late PageController _pageController;
  late StoryPack _pack;
  late List<_InterleavedPage> _pages;
  late String _mascotName;

  int _currentPage = 0;
  bool _showCompletion = false;
  int _correctAnswers = 0;
  int _resetCount = 0;
  final Set<int> _answeredQuestions = {};

  @override
  void initState() {
    super.initState();
    _pack = StoryPackRegistry.getById(widget.packId);
    _mascotName = MascotRegistry.getById(_pack.mascotId).name;
    _pages = _buildInterleavedPages();

    final progress = ref.read(readingProgressProvider);
    final startPage = progress[widget.packId]?.lastPageRead ?? 0;
    final mappedStart = _mapStoryPageToInterleaved(startPage);
    _currentPage = mappedStart;
    _pageController = PageController(initialPage: mappedStart);
  }

  List<_InterleavedPage> _buildInterleavedPages() {
    final pages = <_InterleavedPage>[];
    final questions = _pack.questions;
    final storyCount = _pack.pages.length;

    if (questions.isEmpty) {
      for (var i = 0; i < storyCount; i++) {
        pages.add(_InterleavedPage(_PageType.story, i));
      }
      return pages;
    }

    final interval = storyCount ~/ (questions.length + 1);
    var questionIdx = 0;

    for (var i = 0; i < storyCount; i++) {
      pages.add(_InterleavedPage(_PageType.story, i));
      if (questionIdx < questions.length &&
          (i + 1) % interval == 0 &&
          i < storyCount - 1) {
        pages.add(_InterleavedPage(_PageType.question, questionIdx));
        questionIdx++;
      }
    }

    while (questionIdx < questions.length) {
      pages.add(_InterleavedPage(_PageType.question, questionIdx));
      questionIdx++;
    }

    return pages;
  }

  int _mapStoryPageToInterleaved(int storyPage) {
    for (var i = 0; i < _pages.length; i++) {
      if (_pages[i].type == _PageType.story && _pages[i].index >= storyPage) {
        return i;
      }
    }
    return 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get _canAdvance {
    final current = _pages[_currentPage];
    if (current.type == _PageType.question) {
      return _answeredQuestions.contains(current.index);
    }
    return true;
  }

  void _goNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishStory();
    }
  }

  void _finishStory() {
    ref.read(readingProgressProvider.notifier).markCompleted(widget.packId);

    final total = _pack.questions.length;
    final stars = StoryScore.calculateStars(_correctAnswers, total);
    if (total > 0) {
      final score = StoryScore(
        packId: widget.packId,
        correctAnswers: _correctAnswers,
        totalQuestions: total,
        stars: stars,
        completedAt: DateTime.now(),
      );
      ref.read(storyScoresProvider.notifier).saveScore(score);
    }

    setState(() => _showCompletion = true);
  }

  @override
  Widget build(BuildContext context) {
    final appMode = ref.watch(appModeProvider);

    if (_showCompletion) {
      return Scaffold(
        body: StoryCompleteOverlay(
          mascotName: _mascotName,
          stars: StoryScore.calculateStars(
            _correctAnswers,
            _pack.questions.length,
          ),
          correctAnswers: _correctAnswers,
          totalQuestions: _pack.questions.length,
          onReadAgain: () {
            _pageController.dispose();
            _pageController = PageController(initialPage: 0);
            setState(() {
              _showCompletion = false;
              _currentPage = 0;
              _correctAnswers = 0;
              _resetCount++;
              _answeredQuestions.clear();
            });
          },
          onDone: () => context.pop(),
        ),
      );
    }

    final currentInterleavedPage = _pages[_currentPage];
    final isQuestionPage = currentInterleavedPage.type == _PageType.question;

    return Scaffold(
      backgroundColor: isQuestionPage
          ? AnimalColors.background
          : _pack.pages[currentInterleavedPage.index].sceneColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _pack.title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.md),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.md,
                  vertical: Dimensions.xs,
                ),
                decoration: BoxDecoration(
                  color: AnimalColors.primaryLight,
                  borderRadius: BorderRadius.circular(Dimensions.radiusRound),
                  border: Border.all(
                    color: AnimalColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  isQuestionPage
                      ? 'Quiz'
                      : '${currentInterleavedPage.index + 1} / ${_pack.pages.length}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AnimalColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: _canAdvance
                  ? const ClampingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
                final page = _pages[index];
                if (page.type == _PageType.story) {
                  ref
                      .read(readingProgressProvider.notifier)
                      .updatePage(widget.packId, page.index);
                }
              },
              itemBuilder: (context, index) {
                final page = _pages[index];
                if (page.type == _PageType.question) {
                  return QuestionPageView(
                    key: ValueKey('q_${page.index}_$_resetCount'),
                    question: _pack.questions[page.index],
                    mascotName: _mascotName,
                    onAnswered: _goNext,
                    onResult: (correct) {
                      _answeredQuestions.add(page.index);
                      if (correct) _correctAnswers++;
                    },
                  );
                }
                return _StoryPageView(
                  page: _pack.pages[page.index],
                  isChildMode: appMode == AppMode.child,
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.md),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 4,
                      dotColor: AnimalColors.border,
                      activeDotColor: isQuestionPage
                          ? AnimalColors.accent
                          : AnimalColors.primary,
                    ),
                  ),
                  const SizedBox(height: Dimensions.md),
                  if (!isQuestionPage)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _currentPage > 0
                            ? TextButton.icon(
                                onPressed: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                icon: const Icon(Icons.arrow_back_rounded),
                                label: const Text('Back'),
                              )
                            : const SizedBox(width: 100),
                        _currentPage < _pages.length - 1
                            ? CartoonButton(
                                label: 'Next',
                                icon: Icons.arrow_forward_rounded,
                                onPressed: _goNext,
                              )
                            : CartoonButton(
                                label: 'Finish',
                                icon: Icons.auto_awesome,
                                color: AnimalColors.accent,
                                onPressed: _finishStory,
                              ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryPageView extends StatelessWidget {
  final StoryPage page;
  final bool isChildMode;

  const _StoryPageView({required this.page, required this.isChildMode});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Dimensions.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: page.sceneColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusXl),
              border: Border.all(
                color: AnimalColors.borderBold.withValues(alpha: 0.3),
                width: Dimensions.borderMd,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 48,
                    color: AnimalColors.textTertiary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: Dimensions.sm),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.lg,
                    ),
                    child: Text(
                      page.visualDescription,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AnimalColors.textTertiary,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimensions.lg),
          Text(
            page.narration,
            style: isChildMode
                ? Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontSize: 22, height: 1.7)
                : Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
          if (!isChildMode) ...[
            const SizedBox(height: Dimensions.lg),
            Container(
              padding: const EdgeInsets.all(Dimensions.md),
              decoration: BoxDecoration(
                color: AnimalColors.secondaryLight,
                borderRadius: BorderRadius.circular(Dimensions.radiusXl),
                border: Border.all(
                  color: AnimalColors.secondary.withValues(alpha: 0.3),
                  width: Dimensions.borderThin,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.lightbulb_rounded,
                    size: 22,
                    color: AnimalColors.secondary,
                  ),
                  const SizedBox(width: Dimensions.sm),
                  Expanded(
                    child: Text(
                      page.learningCue,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AnimalColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
