import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/age_groups.dart';
import '../../../core/constants/regions.dart';
import '../../../core/constants/safety_themes.dart';
import '../../../data/story_packs/story_pack_registry.dart';
import '../../../domain/models/story_pack.dart';

final regionFilterProvider = StateProvider<Region?>((ref) => null);
final themeFilterProvider = StateProvider<SafetyTheme?>((ref) => null);
final ageFilterProvider = StateProvider<AgeGroup?>((ref) => null);

final filteredPacksProvider = Provider<List<StoryPack>>((ref) {
  final packs = StoryPackRegistry.allPacks;
  final regionFilter = ref.watch(regionFilterProvider);
  final themeFilter = ref.watch(themeFilterProvider);
  final ageFilter = ref.watch(ageFilterProvider);

  return packs.where((pack) {
    if (regionFilter != null && pack.regionId != regionFilter.id) return false;
    if (themeFilter != null && pack.safetyTheme != themeFilter) return false;
    if (ageFilter != null && !pack.ageGroups.contains(ageFilter)) return false;
    return true;
  }).toList();
});
