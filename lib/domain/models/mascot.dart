import 'package:flutter/material.dart';

class Mascot {
  final String id;
  final String name;
  final String species;
  final String regionId;
  final String personality;
  final String bio;
  final String safetyRole;
  final String catchphrase;
  final IconData icon;

  const Mascot({
    required this.id,
    required this.name,
    required this.species,
    required this.regionId,
    required this.personality,
    required this.bio,
    required this.safetyRole,
    required this.catchphrase,
    required this.icon,
  });
}
