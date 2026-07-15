import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../persistence/preferences_service.dart';
import 'persistence_providers.dart';

/// State notifier for managing language selections per story pack
class PackLanguageNotifier extends StateNotifier<Map<String, String>> {
  PackLanguageNotifier(this._preferencesService) : super({}) {
    _loadLanguages();
  }

  final PreferencesService _preferencesService;

  void _loadLanguages() {
    state = _preferencesService.getPackLanguages();
  }

  /// Get selected language for a pack, returns null if not set
  String? getLanguage(String packId) {
    return state[packId];
  }

  /// Set language for a specific pack
  Future<void> setLanguage(String packId, String languageCode) async {
    state = {...state, packId: languageCode};
    await _preferencesService.setPackLanguage(packId, languageCode);
  }

  /// Reset language selection for a pack (remove from state)
  Future<void> clearLanguage(String packId) async {
    final newState = Map<String, String>.from(state);
    newState.remove(packId);
    state = newState;
    await _preferencesService.setPackLanguages(newState);
  }

  /// Clear all language selections
  Future<void> clearAll() async {
    state = {};
    await _preferencesService.setPackLanguages({});
  }
}

/// Provider for pack language selections
final packLanguageProvider =
    StateNotifierProvider<PackLanguageNotifier, Map<String, String>>((ref) {
      final prefsService = ref.watch(preferencesServiceProvider);
      return PackLanguageNotifier(prefsService);
    });

/// Convenience provider to get language for a specific pack
final packLanguageForIdProvider = Provider.family<String?, String>((
  ref,
  packId,
) {
  final languages = ref.watch(packLanguageProvider);
  return languages[packId];
});
