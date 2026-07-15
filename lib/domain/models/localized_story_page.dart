import 'package:flutter/material.dart';

/// Localized version of a story page
class LocalizedStoryPage {
  final int pageNumber;
  final String narration;
  final String visualDescription;
  final String learningCue;
  final Color sceneColor;
  final String imageUrl;

  const LocalizedStoryPage({
    required this.pageNumber,
    required this.narration,
    required this.visualDescription,
    required this.learningCue,
    required this.sceneColor,
    this.imageUrl = '',
  });
}
