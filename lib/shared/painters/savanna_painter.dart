import 'package:flutter/material.dart';

/// Paints a warm African savanna background.
/// Orange/gold gradient sky with acacia tree silhouettes.
class SavannaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // -- Sky gradient (warm orange to gold) --
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE87C2A), Color(0xFFF5C34B), Color(0xFFFDE8A0)],
        stops: [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), skyPaint);

    // -- Ground strip --
    final groundPaint = Paint()..color = const Color(0xFFC49A3C);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.78, w, h * 0.22), groundPaint);

    // -- Acacia tree silhouettes --
    final treePaint = Paint()
      ..color = const Color(0xFF5C3A1E).withValues(alpha: 0.7);

    _drawAcacia(canvas, w * 0.2, h * 0.78, h * 0.3, w * 0.22, treePaint);
    _drawAcacia(canvas, w * 0.7, h * 0.78, h * 0.22, w * 0.17, treePaint);

    // -- Distant small tree --
    final distantPaint = Paint()
      ..color = const Color(0xFF5C3A1E).withValues(alpha: 0.35);
    _drawAcacia(canvas, w * 0.45, h * 0.78, h * 0.12, w * 0.1, distantPaint);

    // -- Sun --
    final sunPaint = Paint()
      ..color = const Color(0xFFFFF3C4).withValues(alpha: 0.8);
    canvas.drawCircle(Offset(w * 0.8, h * 0.15), w * 0.08, sunPaint);
  }

  /// Draws a flat-topped acacia tree silhouette.
  void _drawAcacia(
    Canvas canvas,
    double x,
    double groundY,
    double height,
    double canopyW,
    Paint paint,
  ) {
    // Trunk
    final trunkW = canopyW * 0.08;
    canvas.drawRect(
      Rect.fromLTWH(x - trunkW / 2, groundY - height, trunkW, height),
      paint,
    );
    // Flat canopy (wide ellipse)
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(x, groundY - height),
        width: canopyW,
        height: height * 0.3,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
