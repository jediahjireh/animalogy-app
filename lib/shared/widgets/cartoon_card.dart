import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';

class CartoonCard extends StatelessWidget {
  final Widget child;
  final Color? borderColor;
  final VoidCallback? onTap;
  final bool rotate;
  final EdgeInsetsGeometry? padding;

  const CartoonCard({
    super.key,
    required this.child,
    this.borderColor,
    this.onTap,
    this.rotate = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final border = borderColor ?? AnimalColors.border;
    final rotation = rotate
        ? (Random(child.hashCode).nextDouble() - 0.5) *
              Dimensions.cardRotationMax *
              2 *
              pi /
              180
        : 0.0;

    return Transform.rotate(
      angle: rotation,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: padding ?? const EdgeInsets.all(Dimensions.md),
          decoration: BoxDecoration(
            color: AnimalColors.surface,
            borderRadius: BorderRadius.circular(Dimensions.radiusXl),
            border: Border.all(color: border, width: Dimensions.borderMd),
            boxShadow: const [
              BoxShadow(
                color: AnimalColors.cardShadow,
                offset: Offset(0, 3),
                blurRadius: 8,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
