import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class StarDisplay extends StatelessWidget {
  final int stars;
  final int maxStars;
  final double size;

  const StarDisplay({
    super.key,
    required this.stars,
    this.maxStars = 3,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (i) {
        final filled = i < stars;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Icon(
            filled ? Icons.star_rounded : Icons.star_outline_rounded,
            color: filled ? AnimalColors.accent : AnimalColors.border,
            size: size,
          ),
        );
      }),
    );
  }
}
