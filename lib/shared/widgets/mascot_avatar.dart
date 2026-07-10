import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../domain/models/mascot.dart';

class MascotAvatar extends StatelessWidget {
  final Mascot mascot;
  final double size;
  final Color? borderColor;
  final double borderWidth;
  final bool showGradient;

  const MascotAvatar({
    super.key,
    required this.mascot,
    this.size = Dimensions.mascotAvatarMd,
    this.borderColor,
    this.borderWidth = Dimensions.borderMd,
    this.showGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = borderColor ?? AnimalColors.regionColor(mascot.regionId);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: showGradient
            ? LinearGradient(
                colors: [
                  color.withValues(alpha: 0.25),
                  color.withValues(alpha: 0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: showGradient ? null : color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withValues(alpha: 0.4),
          width: borderWidth,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: mascot.imageUrl.isNotEmpty
          ? Padding(
              padding: EdgeInsets.all(size * 0.1),
              child: Image.network(
                mascot.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  mascot.icon,
                  size: size * 0.45,
                  color: color,
                ),
              ),
            )
          : Icon(
              mascot.icon,
              size: size * 0.45,
              color: color,
            ),
    );
  }
}
