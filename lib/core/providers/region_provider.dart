import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/regions.dart';
import 'persistence_providers.dart';

final selectedRegionProvider =
    StateNotifierProvider<SelectedRegionNotifier, Region?>((ref) {
      final prefs = ref.read(preferencesServiceProvider);
      return SelectedRegionNotifier(prefs.getSelectedRegion(), ref);
    });

final hasSelectedRegionProvider = Provider<bool>((ref) {
  return ref.watch(selectedRegionProvider) != null;
});

class SelectedRegionNotifier extends StateNotifier<Region?> {
  final Ref _ref;

  SelectedRegionNotifier(super.initialRegion, this._ref);

  Future<void> select(Region region) async {
    state = region;
    await _ref.read(preferencesServiceProvider).setSelectedRegion(region);
  }
}
