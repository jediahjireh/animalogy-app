import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Paints a South American rainforest background.
/// Deep green gradient with scattered tropical leaf shapes.
class RainforestPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // -- Deep green gradient --
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF0D3B1E), Color(0xFF1B5E30), Color(0xFF2E7D42)],
        stops: [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    // -- Forest floor --
    final floorPaint = Paint()
      ..color = const Color(0xFF1A3D1F).withValues(alpha: 0.7);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.85, w, h * 0.15), floorPaint);

    // -- Canopy leaves (top area, overlapping) --
    final darkLeaf = Paint()
      ..color = const Color(0xFF0A2E14).withValues(alpha: 0.5);
    final midLeaf = Paint()
      ..color = const Color(0xFF1A5C2A).withValues(alpha: 0.45);
    final lightLeaf = Paint()
      ..color = const Color(0xFF3A8B4A).withValues(alpha: 0.4);

    // Top canopy layer
    _drawLeaf(canvas, w * 0.1, h * 0.05, w * 0.15, -0.3, darkLeaf);
    _drawLeaf(canvas, w * 0.35, h * 0.02, w * 0.12, 0.2, darkLeaf);
    _drawLeaf(canvas, w * 0.7, h * 0.08, w * 0.14, -0.1, darkLeaf);
    _drawLeaf(canvas, w * 0.9, h * 0.03, w * 0.13, 0.4, darkLeaf);

    // Mid layer
    _drawLeaf(canvas, w * 0.05, h * 0.25, w * 0.11, 0.5, midLeaf);
    _drawLeaf(canvas, w * 0.55, h * 0.2, w * 0.1, -0.4, midLeaf);
    _drawLeaf(canvas, w * 0.85, h * 0.3, w * 0.09, 0.1, midLeaf);

    // Scattered lower leaves
    _drawLeaf(canvas, w * 0.2, h * 0.55, w * 0.08, -0.6, lightLeaf);
    _drawLeaf(canvas, w * 0.75, h * 0.6, w * 0.07, 0.3, lightLeaf);

    // -- Hanging vines --
    final vinePaint = Paint()
      ..color = const Color(0xFF2D6B3A).withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.008
      ..strokeCap = StrokeCap.round;
    final vine1 = Path()
      ..moveTo(w * 0.25, 0)
      ..quadraticBezierTo(w * 0.22, h * 0.2, w * 0.28, h * 0.35);
    canvas.drawPath(vine1, vinePaint);
    final vine2 = Path()
      ..moveTo(w * 0.65, 0)
      ..quadraticBezierTo(w * 0.68, h * 0.15, w * 0.62, h * 0.28);
    canvas.drawPath(vine2, vinePaint);

    // -- Light filtering through canopy --
    final lightPaint = Paint()
      ..color = const Color(0xFFAADD88).withValues(alpha: 0.12);
    canvas.drawCircle(Offset(w * 0.4, h * 0.35), w * 0.15, lightPaint);
    canvas.drawCircle(Offset(w * 0.6, h * 0.45), w * 0.1, lightPaint);
  }

  /// Draws a single elongated tropical leaf shape.
  void _drawLeaf(
    Canvas canvas,
    double x,
    double y,
    double len,
    double angle,
    Paint paint,
  ) {
    canvas.save();
    canvas.translate(x, y);
    canvas.rotate(angle);
    final path = Path()
      ..moveTo(0, -len * 0.5)
      ..quadraticBezierTo(len * 0.35, -len * 0.1, 0, len * 0.5)
      ..quadraticBezierTo(-len * 0.35, -len * 0.1, 0, -len * 0.5)
      ..close();
    canvas.drawPath(path, paint);

    // Leaf midrib
    final ribPaint = Paint()
      ..color = paint.color.withValues(
        alpha: math.min(1.0, (paint.color.a / 255) + 0.15),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = len * 0.03;
    canvas.drawLine(Offset(0, -len * 0.45), Offset(0, len * 0.45), ribPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
