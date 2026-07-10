import 'package:flutter/material.dart';
import '../../domain/models/mascot.dart';

abstract final class MascotRegistry {
  static const List<Mascot> allMascots = [
    Mascot(
      id: 'kaia_meerkat',
      name: 'Kaia',
      species: 'Meerkat',
      regionId: 'southern_africa',
      personality: 'Watchful, brave, and protective of her colony',
      bio:
          'Kaia grew up in a bustling meerkat family in the Kalahari Desert. '
          'She learned early that staying alert keeps everyone safe. As the '
          'youngest lookout in her colony, she takes her job seriously but '
          'always finds time for a beetle snack with friends.',
      safetyRole:
          'The Lookout \u2014 teaches about spotting deception and false information',
      catchphrase: 'Look before you leap!',
      icon: Icons.visibility,
      imageUrl: 'https://openclipart.org/image/800px/355165',
    ),
    Mascot(
      id: 'daisy_dingo',
      name: 'Daisy',
      species: 'Dingo',
      regionId: 'australia',
      personality: 'Sharp, skeptical, and fiercely independent',
      bio:
          'Daisy roams the Australian outback with her pack, learning the '
          'rhythms of the bush. She questions everything \u2014 from suspicious '
          'sounds to unfamiliar scents. Her motto: if something seems off, '
          'check twice before you act.',
      safetyRole:
          'The Skeptic \u2014 teaches about questioning false alarms and misinformation',
      catchphrase: 'If it sounds dodgy, it probably is!',
      icon: Icons.hearing,
      imageUrl: 'https://openclipart.org/image/800px/355582',
    ),
    Mascot(
      id: 'tara_turtle',
      name: 'Tara',
      species: 'Star Tortoise',
      regionId: 'india',
      personality: 'Wise, patient, and thoughtful',
      bio:
          'Tara lives near a winding river in the Indian jungle. She moves '
          'slowly but thinks deeply. While others rush, Tara observes. She '
          'knows that the sweetest words sometimes hide the sharpest teeth, '
          'and she teaches her friends to listen with their heads.',
      safetyRole:
          'The Wise One \u2014 teaches about resisting flattery and manipulation',
      catchphrase: 'Sweet words can hide sharp teeth.',
      icon: Icons.shield,
      imageUrl: 'https://openclipart.org/image/800px/355182',
    ),
    Mascot(
      id: 'luma_capybara',
      name: 'Luma',
      species: 'Capybara',
      regionId: 'brazil',
      personality: 'Gentle, social, and perceptive',
      bio:
          'Luma lives along the Amazon riverbank surrounded by friends of all '
          'species. She is calm and kind, but beneath her gentle nature lies '
          'sharp instincts. Luma notices things others miss \u2014 the ripple '
          'that does not match the current, the log that shifts too smoothly.',
      safetyRole: 'The Sensor \u2014 teaches about recognizing hidden dangers',
      catchphrase: 'Not everything friendly is safe.',
      icon: Icons.search,
      imageUrl: 'https://openclipart.org/image/800px/355183',
    ),
    Mascot(
      id: 'ricky_raccoon',
      name: 'Ricky',
      species: 'Raccoon',
      regionId: 'north_america',
      personality: 'Clever, curious, and resilient',
      bio:
          'Ricky lives at the edge of a North American forest where the trees '
          'meet the meadow. He is street-smart and resourceful, always finding '
          'creative solutions. But his biggest lesson was learning that even '
          'those who seem wise can choose to be unkind.',
      safetyRole:
          'The Street-Smart One \u2014 teaches about trust and betrayal',
      catchphrase: 'Trust is earned, not given.',
      icon: Icons.psychology,
      imageUrl: 'https://openclipart.org/image/800px/355825',
    ),
  ];

  static Mascot getById(String id) => allMascots.firstWhere((m) => m.id == id);

  static Mascot getByRegion(String regionId) =>
      allMascots.firstWhere((m) => m.regionId == regionId);
}
