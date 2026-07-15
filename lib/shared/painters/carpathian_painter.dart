import 'package:flutter/material.dart';

/// Paints a Carpathian Mountains forest background.
/// Deep green gradient with beech and spruce trees, mountain backdrop.
class CarpathianPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // -- Sky gradient (mountain blue-grey to forest green) --
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF7FA8C9), Color(0xFF5A8E5A), Color(0xFF3D6B3D)],
        stops: [0.0, 0.45, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    // -- Distant mountain silhouette --
    final mountainPaint = Paint()
      ..color = const Color(0xFF4A5E5A).withValues(alpha: 0.4);
    final mountainPath = Path()
      ..moveTo(0, h * 0.35)
      ..lineTo(w * 0.2, h * 0.25)
      ..lineTo(w * 0.35, h * 0.30)
      ..lineTo(w * 0.55, h * 0.18)
      ..lineTo(w * 0.75, h * 0.28)
      ..lineTo(w * 0.95, h * 0.22)
      ..lineTo(w, h * 0.35)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(mountainPath, mountainPaint);

    // -- Forest floor --
    final floorPaint = Paint()..color = const Color(0xFF2D4A2D);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.80, w, h * 0.20), floorPaint);

    // -- Back row of beech/spruce trees (darker, smaller) --
    final backPaint = Paint()
      ..color = const Color(0xFF1A3D1E).withValues(alpha: 0.65);
    _drawSpruce(canvas, w * 0.12, h * 0.80, h * 0.30, w * 0.09, backPaint);
    _drawBeech(canvas, w * 0.28, h * 0.80, h * 0.28, w * 0.12, backPaint);
    _drawSpruce(canvas, w * 0.50, h * 0.80, h * 0.26, w * 0.08, backPaint);
    _drawBeech(canvas, w * 0.72, h * 0.80, h * 0.32, w * 0.13, backPaint);
    _drawSpruce(canvas, w * 0.90, h * 0.80, h * 0.24, w * 0.07, backPaint);

    // -- Front row of trees (larger, more prominent) --
    final frontPaint = Paint()
      ..color = const Color(0xFF2A5030).withValues(alpha: 0.80);
    _drawBeech(canvas, w * 0.18, h * 0.80, h * 0.48, w * 0.16, frontPaint);
    _drawSpruce(canvas, w * 0.45, h * 0.80, h * 0.52, w * 0.14, frontPaint);
    _drawBeech(canvas, w * 0.78, h * 0.80, h * 0.46, w * 0.15, frontPaint);

    // -- Mountain mist layers --
    final mistPaint = Paint()
      ..color = const Color(0xFFB8D4C4).withValues(alpha: 0.15);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.40, w, h * 0.08), mistPaint);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.60, w, h * 0.06), mistPaint);

    // -- Filtered sunlight through canopy --
    final lightPaint = Paint()
      ..color = const Color(0xFFE8E4C4).withValues(alpha: 0.18);
    canvas.drawCircle(Offset(w * 0.35, h * 0.20), w * 0.14, lightPaint);

    // -- Scattered rocks on forest floor --
    final rockPaint = Paint()
      ..color = const Color(0xFF5A5047).withValues(alpha: 0.55);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.30, h * 0.86),
        width: w * 0.03,
        height: h * 0.012,
      ),
      rockPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.62, h * 0.88),
        width: w * 0.025,
        height: h * 0.010,
      ),
      rockPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.85, h * 0.85),
        width: w * 0.028,
        height: h * 0.011,
      ),
      rockPaint,
    );

    // -- Ferns/undergrowth --
    final fernPaint = Paint()
      ..color = const Color(0xFF4A7350).withValues(alpha: 0.45);
    _drawFern(canvas, w * 0.10, h * 0.82, w * 0.05, fernPaint);
    _drawFern(canvas, w * 0.55, h * 0.84, w * 0.04, fernPaint);
    _drawFern(canvas, w * 0.92, h * 0.83, w * 0.045, fernPaint);
  }

  /// Draws a triangular spruce/conifer tree silhouette (narrow, pointed)
  void _drawSpruce(
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

    // Layered triangular canopy (3 narrow tiers)
    for (int tier = 0; tier < 3; tier++) {
      final tierY = groundY - height * 0.15 - (height * 0.28 * tier);
      final tierWidth = halfWidth * (1.0 - tier * 0.25);
      final tierHeight = height * 0.38;
      final treePath = Path()
        ..moveTo(x, tierY - tierHeight)
        ..lineTo(x + tierWidth, tierY)
        ..lineTo(x - tierWidth, tierY)
        ..close();
      canvas.drawPath(treePath, paint);
    }
  }

  /// Draws a broad beech tree with rounded canopy
  void _drawBeech(
    Canvas canvas,
    double x,
    double groundY,
    double height,
    double canopyWidth,
    Paint paint,
  ) {
    // Trunk
    final trunkW = canopyWidth * 0.12;
    final trunkPaint = Paint()
      ..color = const Color(0xFF3E2E1E).withValues(alpha: paint.color.a);
    canvas.drawRect(
      Rect.fromLTWH(x - trunkW / 2, groundY - height, trunkW, height),
      trunkPaint,
    );

    // Rounded canopy (broad oval, like a beech)
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(x, groundY - height * 0.75),
        width: canopyWidth,
        height: height * 0.55,
      ),
      paint,
    );
  }

  /// Draws a simple fern/undergrowth shape
  void _drawFern(Canvas canvas, double x, double y, double size, Paint paint) {
    final path = Path()
      ..moveTo(x, y)
      ..quadraticBezierTo(
        x - size * 0.3,
        y - size * 0.5,
        x - size * 0.2,
        y - size,
      )
      ..moveTo(x, y)
      ..quadraticBezierTo(
        x + size * 0.3,
        y - size * 0.5,
        x + size * 0.2,
        y - size,
      )
      ..moveTo(x, y)
      ..lineTo(x, y - size * 0.8);
    canvas.drawPath(
      path,
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = size * 0.08,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
