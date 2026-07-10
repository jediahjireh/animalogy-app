import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_dimensions.dart';

enum BubbleTailDirection { left, right, bottomCenter }

class SpeechBubble extends StatelessWidget {
  final Widget child;
  final BubbleTailDirection tailDirection;
  final Color? backgroundColor;
  final Color? borderColor;

  const SpeechBubble({
    super.key,
    required this.child,
    this.tailDirection = BubbleTailDirection.left,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AnimalColors.surface;
    final border = borderColor ?? AnimalColors.borderBold;

    return CustomPaint(
      painter: _BubblePainter(
        backgroundColor: bg,
        borderColor: border,
        tailDirection: tailDirection,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: tailDirection == BubbleTailDirection.left
              ? Dimensions.bubblePadding + 8
              : Dimensions.bubblePadding,
          right: tailDirection == BubbleTailDirection.right
              ? Dimensions.bubblePadding + 8
              : Dimensions.bubblePadding,
          top: Dimensions.bubblePadding,
          bottom: tailDirection == BubbleTailDirection.bottomCenter
              ? Dimensions.bubblePadding + 8
              : Dimensions.bubblePadding,
        ),
        child: child,
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  final Color backgroundColor;
  final Color borderColor;
  final BubbleTailDirection tailDirection;

  _BubblePainter({
    required this.backgroundColor,
    required this.borderColor,
    required this.tailDirection,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = Dimensions.borderMd;

    const r = Dimensions.radiusLg;
    const tail = Dimensions.bubbleTailSize;

    final rect = switch (tailDirection) {
      BubbleTailDirection.left => RRect.fromLTRBR(
        6,
        0,
        size.width,
        size.height,
        const Radius.circular(r),
      ),
      BubbleTailDirection.right => RRect.fromLTRBR(
        0,
        0,
        size.width - 6,
        size.height,
        const Radius.circular(r),
      ),
      BubbleTailDirection.bottomCenter => RRect.fromLTRBR(
        0,
        0,
        size.width,
        size.height - 6,
        const Radius.circular(r),
      ),
    };

    canvas.drawRRect(rect, fillPaint);
    canvas.drawRRect(rect, borderPaint);

    final tailPath = Path();
    switch (tailDirection) {
      case BubbleTailDirection.left:
        final cy = size.height * 0.4;
        tailPath.moveTo(6, cy - tail / 2);
        tailPath.lineTo(0, cy);
        tailPath.lineTo(6, cy + tail / 2);
      case BubbleTailDirection.right:
        final cy = size.height * 0.4;
        tailPath.moveTo(size.width - 6, cy - tail / 2);
        tailPath.lineTo(size.width, cy);
        tailPath.lineTo(size.width - 6, cy + tail / 2);
      case BubbleTailDirection.bottomCenter:
        final cx = size.width * 0.3;
        tailPath.moveTo(cx - tail / 2, size.height - 6);
        tailPath.lineTo(cx, size.height);
        tailPath.lineTo(cx + tail / 2, size.height - 6);
    }

    canvas.drawPath(tailPath, fillPaint);
    canvas.drawPath(tailPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _BubblePainter old) =>
      old.backgroundColor != backgroundColor ||
      old.borderColor != borderColor ||
      old.tailDirection != tailDirection;
}
