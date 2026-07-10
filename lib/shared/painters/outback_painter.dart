import 'package:flutter/material.dart';

/// Paints an Australian outback background.
/// Red earth gradient with sparse bush dots and shapes.
class OutbackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // -- Sky gradient (dusty blue to hazy peach) --
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF7BAFD4), Color(0xFFE8C49A), Color(0xFFD4734A)],
        stops: [0.0, 0.45, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), skyPaint);

    // -- Red earth ground --
    final groundPaint = Paint()..color = const Color(0xFFC0451E);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.65, w, h * 0.35), groundPaint);

    // -- Horizon line blend --
    final horizonPaint = Paint()..color = const Color(0xFFD4734A);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.63, w, h * 0.06), horizonPaint);

    // -- Sparse scrub bushes --
    final bushPaint = Paint()
      ..color = const Color(0xFF5A6E3A).withValues(alpha: 0.6);
    _drawBush(canvas, w * 0.15, h * 0.72, w * 0.07, bushPaint);
    _drawBush(canvas, w * 0.55, h * 0.70, w * 0.05, bushPaint);
    _drawBush(canvas, w * 0.85, h * 0.74, w * 0.06, bushPaint);

    // -- Distant scrub dots --
    final dotPaint = Paint()
      ..color = const Color(0xFF6B7D45).withValues(alpha: 0.4);
    final dotPositions = [
      [0.25, 0.68],
      [0.40, 0.67],
      [0.65, 0.69],
      [0.78, 0.68],
      [0.92, 0.67],
      [0.10, 0.69],
    ];
    for (final pos in dotPositions) {
      canvas.drawCircle(Offset(w * pos[0], h * pos[1]), w * 0.012, dotPaint);
    }

    // -- Scattered ground rocks --
    final rockPaint = Paint()
      ..color = const Color(0xFF8B3A16).withValues(alpha: 0.5);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.3, h * 0.82),
        width: w * 0.04,
        height: h * 0.015,
      ),
      rockPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.7, h * 0.85),
        width: w * 0.03,
        height: h * 0.012,
      ),
      rockPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.9),
        width: w * 0.035,
        height: h * 0.013,
      ),
      rockPaint,
    );

    // -- Sun/heat haze --
    final sunPaint = Paint()
      ..color = const Color(0xFFFFF3C4).withValues(alpha: 0.6);
    canvas.drawCircle(Offset(w * 0.75, h * 0.12), w * 0.07, sunPaint);
  }

  void _drawBush(
    Canvas canvas,
    double x,
    double y,
    double radius,
    Paint paint,
  ) {
    // Cluster of overlapping circles
    canvas.drawCircle(Offset(x, y), radius, paint);
    canvas.drawCircle(
      Offset(x - radius * 0.5, y + radius * 0.2),
      radius * 0.7,
      paint,
    );
    canvas.drawCircle(
      Offset(x + radius * 0.5, y + radius * 0.15),
      radius * 0.75,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
