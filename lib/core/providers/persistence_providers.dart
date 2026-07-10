import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../persistence/preferences_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Must be overridden in ProviderScope');
});

final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  return PreferencesService(ref.read(sharedPreferencesProvider));
});
