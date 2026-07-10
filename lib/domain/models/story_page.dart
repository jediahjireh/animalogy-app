import 'package:flutter/material.dart';

class StoryPage {
  final int pageNumber;
  final String narration;
  final String visualDescription;
  final String learningCue;
  final Color sceneColor;
  final String imageUrl;

  const StoryPage({
    required this.pageNumber,
    required this.narration,
    required this.visualDescription,
    required this.learningCue,
    required this.sceneColor,
    this.imageUrl = '',
  });
}
