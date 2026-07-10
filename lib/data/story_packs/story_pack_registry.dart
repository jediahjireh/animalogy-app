import '../../domain/models/story_pack.dart';
import 'kaia_meerkat_pack.dart';
import 'daisy_dingo_pack.dart';
import 'tara_turtle_pack.dart';
import 'luma_capybara_pack.dart';
import 'ricky_raccoon_pack.dart';

class StoryPackRegistry {
  StoryPackRegistry._();

  static final List<StoryPack> allPacks = [
    ...kaiaMeerkatPacks,
    ...daisyDingoPacks,
    ...taraTurtlePacks,
    ...lumaCapybaraPacks,
    ...rickyRaccoonPacks,
  ];

  static final Map<String, StoryPack> _byId = {
    for (final pack in allPacks) pack.id: pack,
  };

  static StoryPack getById(String id) => _byId[id]!;

  static List<StoryPack> getByRegion(String regionId) =>
      allPacks.where((p) => p.regionId == regionId).toList();
}
