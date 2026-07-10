import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/utils/haptic_utils.dart';

class CartoonButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final IconData? icon;
  final bool expanded;

  const CartoonButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor,
    this.icon,
    this.expanded = false,
  });

  @override
  State<CartoonButton> createState() => _CartoonButtonState();
}

class _CartoonButtonState extends State<CartoonButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.color ?? AnimalColors.primary;
    final fg = widget.textColor ?? AnimalColors.textOnPrimary;
    final darkBorder = HSLColor.fromColor(bg)
        .withLightness(
          (HSLColor.fromColor(bg).lightness - 0.15).clamp(0.0, 1.0),
        )
        .toColor();

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        HapticUtils.lightTap();
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.expanded ? double.infinity : null,
        transform: Matrix4.translationValues(
          0,
          _pressed ? Dimensions.borderThick : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(Dimensions.radiusXl),
          border: Border.all(color: darkBorder, width: Dimensions.borderMd),
          boxShadow: _pressed
              ? []
              : [
                  BoxShadow(
                    color: darkBorder.withValues(alpha: 0.6),
                    offset: const Offset(0, Dimensions.borderThick),
                    blurRadius: 0,
                  ),
                ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.xl,
          vertical: Dimensions.md,
        ),
        child: Row(
          mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, color: fg, size: Dimensions.iconMd),
              const SizedBox(width: Dimensions.sm),
            ],
            Text(
              widget.label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: fg,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
