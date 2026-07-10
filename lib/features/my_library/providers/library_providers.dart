import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/persistence_providers.dart';
import '../../../domain/models/reading_progress.dart';
import '../../../domain/models/story_score.dart';

final bookmarksProvider =
    StateNotifierProvider<BookmarksNotifier, List<String>>((ref) {
      final prefs = ref.read(preferencesServiceProvider);
      return BookmarksNotifier(prefs.getBookmarks(), ref);
    });

class BookmarksNotifier extends StateNotifier<List<String>> {
  final Ref _ref;

  BookmarksNotifier(super.initialBookmarks, this._ref);

  Future<void> toggle(String packId) async {
    if (state.contains(packId)) {
      state = state.where((id) => id != packId).toList();
    } else {
      state = [...state, packId];
    }
    await _ref.read(preferencesServiceProvider).setBookmarks(state);
  }

  bool isBookmarked(String packId) => state.contains(packId);
}

final readingProgressProvider =
    StateNotifierProvider<
      ReadingProgressNotifier,
      Map<String, ReadingProgress>
    >((ref) {
      final prefs = ref.read(preferencesServiceProvider);
      return ReadingProgressNotifier(prefs.getReadingProgress(), ref);
    });

class ReadingProgressNotifier
    extends StateNotifier<Map<String, ReadingProgress>> {
  final Ref _ref;

  ReadingProgressNotifier(super.initialProgress, this._ref);

  Future<void> updatePage(String packId, int pageIndex) async {
    final existing = state[packId];
    final updated = ReadingProgress(
      packId: packId,
      lastPageRead: pageIndex,
      completed: existing?.completed ?? false,
    );
    state = {...state, packId: updated};
    await _ref.read(preferencesServiceProvider).setReadingProgress(state);
  }

  Future<void> markCompleted(String packId) async {
    final existing = state[packId];
    final updated = ReadingProgress(
      packId: packId,
      lastPageRead: existing?.lastPageRead ?? 0,
      completed: true,
    );
    state = {...state, packId: updated};
    await _ref.read(preferencesServiceProvider).setReadingProgress(state);
  }
}

final storyScoresProvider =
    StateNotifierProvider<StoryScoresNotifier, Map<String, StoryScore>>((ref) {
      final prefs = ref.read(preferencesServiceProvider);
      return StoryScoresNotifier(prefs.getStoryScores(), ref);
    });

class StoryScoresNotifier extends StateNotifier<Map<String, StoryScore>> {
  final Ref _ref;

  StoryScoresNotifier(super.initialScores, this._ref);

  Future<void> saveScore(StoryScore score) async {
    final existing = state[score.packId];
    if (existing == null || score.stars > existing.stars) {
      state = {...state, score.packId: score};
      await _ref.read(preferencesServiceProvider).setStoryScores(state);
    }
  }

  StoryScore? getScore(String packId) => state[packId];
}
