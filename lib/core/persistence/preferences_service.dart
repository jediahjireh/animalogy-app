import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/app_mode.dart';
import '../../domain/models/reading_progress.dart';
import '../../domain/models/story_score.dart';
import '../constants/regions.dart';

class PreferencesService {
  final SharedPreferences _prefs;

  PreferencesService(this._prefs);

  static const _keyRegion = 'selected_region';
  static const _keyAppMode = 'app_mode';
  static const _keyBookmarks = 'bookmarks';
  static const _keyProgress = 'reading_progress';
  static const _keyScores = 'story_scores';

  Region? getSelectedRegion() {
    final id = _prefs.getString(_keyRegion);
    if (id == null) return null;
    return Region.fromId(id);
  }

  Future<void> setSelectedRegion(Region region) async {
    await _prefs.setString(_keyRegion, region.id);
  }

  AppMode getAppMode() {
    final mode = _prefs.getString(_keyAppMode);
    return mode == 'educator' ? AppMode.educator : AppMode.child;
  }

  Future<void> setAppMode(AppMode mode) async {
    await _prefs.setString(_keyAppMode, mode.name);
  }

  List<String> getBookmarks() {
    return _prefs.getStringList(_keyBookmarks) ?? [];
  }

  Future<void> setBookmarks(List<String> packIds) async {
    await _prefs.setStringList(_keyBookmarks, packIds);
  }

  Map<String, ReadingProgress> getReadingProgress() {
    final raw = _prefs.getString(_keyProgress);
    if (raw == null) return {};
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return map.map(
      (key, value) => MapEntry(
        key,
        ReadingProgress.fromJson(value as Map<String, dynamic>),
      ),
    );
  }

  Future<void> setReadingProgress(Map<String, ReadingProgress> progress) async {
    final map = progress.map((key, value) => MapEntry(key, value.toJson()));
    await _prefs.setString(_keyProgress, jsonEncode(map));
  }

  Map<String, StoryScore> getStoryScores() {
    final raw = _prefs.getString(_keyScores);
    if (raw == null) return {};
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return map.map(
      (key, value) =>
          MapEntry(key, StoryScore.fromJson(value as Map<String, dynamic>)),
    );
  }

  Future<void> setStoryScores(Map<String, StoryScore> scores) async {
    final map = scores.map((key, value) => MapEntry(key, value.toJson()));
    await _prefs.setString(_keyScores, jsonEncode(map));
  }
}
