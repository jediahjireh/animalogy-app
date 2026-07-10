import 'package:flutter/material.dart';
import '../../core/constants/regions.dart';
import '../../core/theme/app_colors.dart';

class RegionIcon extends StatelessWidget {
  final Region region;
  final double size;
  final bool showBackground;

  const RegionIcon({
    super.key,
    required this.region,
    this.size = 24,
    this.showBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    final icon = Icon(region.icon, size: size, color: region.color);

    if (!showBackground) return icon;

    return Container(
      width: size * 1.8,
      height: size * 1.8,
      decoration: BoxDecoration(
        color: region.color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: region.color.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Center(child: icon),
    );
  }

  static IconData iconForRegionId(String regionId) {
    final region = Region.fromId(regionId);
    return region?.icon ?? Icons.public;
  }

  static Color colorForRegionId(String regionId) {
    return AnimalColors.regionColor(regionId);
  }
}
