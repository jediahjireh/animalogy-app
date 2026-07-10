import 'package:flutter_test/flutter_test.dart';
import 'package:animalogy/data/story_packs/story_pack_registry.dart';
import 'package:animalogy/data/mascots/mascot_registry.dart';
import 'package:animalogy/data/skills/skills_registry.dart';

void main() {
  test('StoryPackRegistry contains 5 packs', () {
    expect(StoryPackRegistry.allPacks.length, 5);
  });

  test('Each pack has 8 story pages', () {
    for (final pack in StoryPackRegistry.allPacks) {
      expect(pack.pages.length, 8, reason: '${pack.title} should have 8 pages');
    }
  });

  test('MascotRegistry contains 5 mascots', () {
    expect(MascotRegistry.allMascots.length, 5);
  });

  test('SkillsRegistry contains 5 skills', () {
    expect(SkillsRegistry.allSkills.length, 5);
  });

  test('Each pack can be looked up by ID', () {
    for (final pack in StoryPackRegistry.allPacks) {
      expect(StoryPackRegistry.getById(pack.id), pack);
    }
  });
}
