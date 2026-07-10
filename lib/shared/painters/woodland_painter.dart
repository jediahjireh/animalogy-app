import 'package:flutter/material.dart';

/// Paints a North American woodland background.
/// Forest green/brown gradient with pine tree silhouettes.
class WoodlandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // -- Sky gradient (misty blue-green to forest floor brown) --
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF5A7D6B), Color(0xFF3D5E3A), Color(0xFF4A3A28)],
        stops: [0.0, 0.55, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    // -- Forest floor --
    final floorPaint = Paint()..color = const Color(0xFF3A2E1E);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.82, w, h * 0.18), floorPaint);

    // -- Back row of pines (darker, smaller) --
    final backPaint = Paint()
      ..color = const Color(0xFF1A3A1E).withValues(alpha: 0.6);
    _drawPine(canvas, w * 0.08, h * 0.82, h * 0.28, w * 0.08, backPaint);
    _drawPine(canvas, w * 0.25, h * 0.82, h * 0.32, w * 0.09, backPaint);
    _drawPine(canvas, w * 0.48, h * 0.82, h * 0.25, w * 0.07, backPaint);
    _drawPine(canvas, w * 0.68, h * 0.82, h * 0.30, w * 0.08, backPaint);
    _drawPine(canvas, w * 0.90, h * 0.82, h * 0.27, w * 0.075, backPaint);

    // -- Front row of pines (larger, more prominent) --
    final frontPaint = Paint()
      ..color = const Color(0xFF1A4D25).withValues(alpha: 0.75);
    _drawPine(canvas, w * 0.15, h * 0.82, h * 0.42, w * 0.12, frontPaint);
    _drawPine(canvas, w * 0.42, h * 0.82, h * 0.50, w * 0.14, frontPaint);
    _drawPine(canvas, w * 0.75, h * 0.82, h * 0.45, w * 0.13, frontPaint);

    // -- Mist layers --
    final mistPaint = Paint()
      ..color = const Color(0xFFB0C4B0).withValues(alpha: 0.12);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.45, w, h * 0.08), mistPaint);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.60, w, h * 0.06), mistPaint);

    // -- Filtered sunlight --
    final lightPaint = Paint()
      ..color = const Color(0xFFE8DFC4).withValues(alpha: 0.15);
    canvas.drawCircle(Offset(w * 0.3, h * 0.15), w * 0.12, lightPaint);

    // -- Ground detail (small rocks/mushrooms) --
    final detailPaint = Paint()
      ..color = const Color(0xFF5A4A35).withValues(alpha: 0.5);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.25, h * 0.88),
        width: w * 0.025,
        height: h * 0.01,
      ),
      detailPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.6, h * 0.9),
        width: w * 0.02,
        height: h * 0.008,
      ),
      detailPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.85, h * 0.87),
        width: w * 0.022,
        height: h * 0.009,
      ),
      detailPaint,
    );
  }

  /// Draws a triangular pine/conifer tree silhouette.
  void _drawPine(
    Canvas canvas,
    double x,
    double groundY,
    double height,
    double halfWidth,
    Paint paint,
  ) {
    // Trunk
    final trunkPaint = Paint()
      ..color = const Color(0xFF2E1E0E).withValues(alpha: paint.color.a);
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(x, groundY - height * 0.08),
        width: halfWidth * 0.15,
        height: height * 0.15,
      ),
      trunkPaint,
    );

    // Layered triangular canopy (3 tiers)
    for (int tier = 0; tier < 3; tier++) {
      final tierY = groundY - height * 0.15 - (height * 0.28 * tier);
      final tierWidth = halfWidth * (1.0 - tier * 0.2);
      final tierHeight = height * 0.38;
      final treePath = Path()
        ..moveTo(x, tierY - tierHeight)
        ..lineTo(x + tierWidth, tierY)
        ..lineTo(x - tierWidth, tierY)
        ..close();
      canvas.drawPath(treePath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
