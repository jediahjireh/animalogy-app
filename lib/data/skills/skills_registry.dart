import 'package:flutter/material.dart';
import '../../domain/models/skill.dart';

abstract final class SkillsRegistry {
  static const List<Skill> allSkills = [
    Skill(
      id: 'recognize_deception',
      name: 'Recognizing Deception',
      description:
          'Spot when someone is not telling the truth, online or in person. '
          'Learn the signs that something is not what it seems.',
      icon: Icons.shield_outlined,
      relatedPackIds: ['kaia_bird_danger'],
    ),
    Skill(
      id: 'question_false_alarms',
      name: 'Questioning False Alarms',
      description:
          'Learn to check facts before panicking. Not every warning is real '
          '\u2014 sometimes people create fear to get what they want.',
      icon: Icons.fact_check_outlined,
      relatedPackIds: ['daisy_laughing_trickster'],
    ),
    Skill(
      id: 'resist_manipulation',
      name: 'Resisting Manipulation',
      description:
          'Recognize when flattery or excessive kindness is used to trick you. '
          'Real friends do not need to bribe you with compliments.',
      icon: Icons.psychology_outlined,
      relatedPackIds: ['tara_crocodile_compliment'],
    ),
    Skill(
      id: 'spot_hidden_danger',
      name: 'Spotting Hidden Danger',
      description:
          'Notice when something seems safe but is not. Danger can be patient '
          'and quiet, waiting until you stop paying attention.',
      icon: Icons.visibility_off_outlined,
      relatedPackIds: ['luma_sneaky_snake'],
    ),
    Skill(
      id: 'evaluate_trust',
      name: 'Evaluating Trust',
      description:
          'Understand who deserves your trust and why. Even people in positions '
          'of authority can make choices that hurt others.',
      icon: Icons.verified_user_outlined,
      relatedPackIds: ['ricky_owl_lied'],
    ),
  ];

  static Skill getById(String id) => allSkills.firstWhere((s) => s.id == id);
}
