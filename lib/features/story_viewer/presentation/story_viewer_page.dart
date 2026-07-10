import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/providers/app_mode_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../data/story_packs/story_pack_registry.dart';
import '../../../domain/models/app_mode.dart';
import '../../../domain/models/story_page.dart';
import '../../my_library/providers/library_providers.dart';

class StoryViewerPage extends ConsumerStatefulWidget {
  final String packId;

  const StoryViewerPage({super.key, required this.packId});

  @override
  ConsumerState<StoryViewerPage> createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends ConsumerState<StoryViewerPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    final progress = ref.read(readingProgressProvider);
    final startPage = progress[widget.packId]?.lastPageRead ?? 0;
    _currentPage = startPage;
    _pageController = PageController(initialPage: startPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pack = StoryPackRegistry.getById(widget.packId);
    final appMode = ref.watch(appModeProvider);
    final totalPages = pack.pages.length;

    return Scaffold(
      backgroundColor: pack.pages[_currentPage].sceneColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: Text(pack.title, style: Theme.of(context).textTheme.titleMedium),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.md),
            child: Center(
              child: Text(
                '${_currentPage + 1} / $totalPages',
                style: Theme.of(context).textTheme.labelLarge,
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
              itemCount: totalPages,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
                ref
                    .read(readingProgressProvider.notifier)
                    .updatePage(widget.packId, index);
              },
              itemBuilder: (context, index) {
                final page = pack.pages[index];
                return _StoryPageView(
                  page: page,
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
                    count: totalPages,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 6,
                      dotColor: AnimalColors.border,
                      activeDotColor: AnimalColors.primary,
                    ),
                  ),
                  const SizedBox(height: Dimensions.md),
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
                              icon: const Icon(Icons.arrow_back),
                              label: const Text('Back'),
                            )
                          : const SizedBox(width: 100),
                      _currentPage < totalPages - 1
                          ? ElevatedButton.icon(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: const Icon(Icons.arrow_forward),
                              label: const Text('Next'),
                            )
                          : ElevatedButton.icon(
                              onPressed: () {
                                ref
                                    .read(readingProgressProvider.notifier)
                                    .markCompleted(widget.packId);
                                _showCompletionDialog(context);
                              },
                              icon: const Icon(Icons.celebration),
                              label: const Text('Finish'),
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

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusLg),
        ),
        title: const Text('Great Job!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, size: 64, color: AnimalColors.accent),
            const SizedBox(height: Dimensions.md),
            Text(
              'You finished the story! Remember what you learned today.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.pop();
            },
            child: const Text('Done'),
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
              borderRadius: BorderRadius.circular(Dimensions.radiusLg),
              border: Border.all(
                color: AnimalColors.border.withValues(alpha: 0.5),
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
          const SizedBox(height: Dimensions.lg),
          Container(
            padding: const EdgeInsets.all(Dimensions.md),
            decoration: BoxDecoration(
              color: AnimalColors.secondaryLight,
              borderRadius: BorderRadius.circular(Dimensions.radiusMd),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 20,
                  color: AnimalColors.secondary,
                ),
                const SizedBox(width: Dimensions.sm),
                Expanded(
                  child: Text(
                    page.learningCue,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AnimalColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
