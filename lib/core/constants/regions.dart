import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum Region {
  southAfrica(
    id: 'south_africa',
    name: 'South Africa',
    description: 'Home to meerkats, drongos, and the vast Kalahari.',
    icon: Icons.terrain,
  ),
  australia(
    id: 'australia',
    name: 'Australia',
    description: 'Land of dingoes, kookaburras, and the outback.',
    icon: Icons.landscape,
  ),
  india(
    id: 'india',
    name: 'India',
    description: 'Where star tortoises and crocodiles share ancient rivers.',
    icon: Icons.water,
  ),
  brazil(
    id: 'brazil',
    name: 'Brazil',
    description: 'The Amazon, home to capybaras and stealthy anacondas.',
    icon: Icons.forest,
  ),
  usa(
    id: 'usa',
    name: 'United States',
    description: 'Forests of raccoons, owls, and hidden woodland secrets.',
    icon: Icons.park,
  ),
  romania(
    id: 'romania',
    name: 'Romania',
    description:
        'Ancient forests where brown bears roam beneath towering beech and spruce.',
    icon: Icons.landscape_rounded,
  );

  const Region({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });

  final String id;
  final String name;
  final String description;
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
