import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/app_mode.dart';
import 'persistence_providers.dart';

final appModeProvider = StateNotifierProvider<AppModeNotifier, AppMode>((ref) {
  final prefs = ref.read(preferencesServiceProvider);
  return AppModeNotifier(prefs.getAppMode(), ref);
});

class AppModeNotifier extends StateNotifier<AppMode> {
  final Ref _ref;

  AppModeNotifier(super.initialMode, this._ref);

  void toggle() {
    final next = state == AppMode.child ? AppMode.educator : AppMode.child;
    state = next;
    _ref.read(preferencesServiceProvider).setAppMode(next);
  }

  void setMode(AppMode mode) {
    state = mode;
    _ref.read(preferencesServiceProvider).setAppMode(mode);
  }
}
