import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum Region {
  southernAfrica(
    id: 'southern_africa',
    name: 'Southern Africa',
    description: 'Home to meerkats, drongos, and the vast Kalahari.',
    emoji: '\u{1F30D}',
    icon: Icons.terrain,
  ),
  australia(
    id: 'australia',
    name: 'Australia',
    description: 'Land of dingoes, kookaburras, and the outback.',
    emoji: '\u{1F30F}',
    icon: Icons.landscape,
  ),
  india(
    id: 'india',
    name: 'India',
    description: 'Where star tortoises and crocodiles share ancient rivers.',
    emoji: '\u{1F30F}',
    icon: Icons.water,
  ),
  brazil(
    id: 'brazil',
    name: 'Brazil',
    description: 'The Amazon, home to capybaras and stealthy anacondas.',
    emoji: '\u{1F30E}',
    icon: Icons.forest,
  ),
  northAmerica(
    id: 'north_america',
    name: 'North America',
    description: 'Forests of raccoons, owls, and hidden woodland secrets.',
    emoji: '\u{1F30E}',
    icon: Icons.park,
  );

  const Region({
    required this.id,
    required this.name,
    required this.description,
    required this.emoji,
    required this.icon,
  });

  final String id;
  final String name;
  final String description;
  final String emoji;
  final IconData icon;

  Color get color => AnimalColors.regionColor(id);

  static Region? fromId(String id) {
    try {
      return Region.values.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }
}
