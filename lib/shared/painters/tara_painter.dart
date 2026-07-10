import 'package:flutter/material.dart';

/// Paints a simple cartoon star tortoise face (Tara).
/// Dome shell with star pattern, gentle round eyes, green/brown tones.
class TaraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final unit = size.shortestSide / 2;

    // -- Shell dome (behind head) --
    final shellPaint = Paint()..color = const Color(0xFF3D3121);
    final shellPath = Path()
      ..addArc(
        Rect.fromCenter(
          center: Offset(cx, cy - unit * 0.05),
          width: unit * 1.6,
          height: unit * 1.5,
        ),
        3.14,
        3.14, // top half arc
      )
      ..close();
    canvas.drawPath(shellPath, shellPaint);

    // -- Star pattern rays on shell --
    final starPaint = Paint()
      ..color = const Color(0xFFD4B84A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = unit * 0.06
      ..strokeCap = StrokeCap.round;
    // Radiating lines from centre of shell dome
    const rayAngles = [-2.6, -2.1, -1.57, -1.0, -0.5];
    for (final angle in rayAngles) {
      final startR = unit * 0.15;
      final endR = unit * 0.6;
      canvas.drawLine(
        Offset(
          cx + startR * _cos(angle),
          cy - unit * 0.15 + startR * _sin(angle),
        ),
        Offset(cx + endR * _cos(angle), cy - unit * 0.15 + endR * _sin(angle)),
        starPaint,
      );
    }

    // -- Head --
    final headPaint = Paint()..color = const Color(0xFF6B7D45);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy + unit * 0.3),
        width: unit * 0.7,
        height: unit * 0.65,
      ),
      headPaint,
    );

    // -- Eyes (gentle, round) --
    final eyeWhite = Paint()..color = const Color(0xFFF5F0DA);
    canvas.drawCircle(
      Offset(cx - unit * 0.12, cy + unit * 0.2),
      unit * 0.09,
      eyeWhite,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.12, cy + unit * 0.2),
      unit * 0.09,
      eyeWhite,
    );
    final irisPaint = Paint()..color = const Color(0xFF2E4A1E);
    canvas.drawCircle(
      Offset(cx - unit * 0.12, cy + unit * 0.22),
      unit * 0.055,
      irisPaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.12, cy + unit * 0.22),
      unit * 0.055,
      irisPaint,
    );
    final pupilPaint = Paint()..color = const Color(0xFF111111);
    canvas.drawCircle(
      Offset(cx - unit * 0.12, cy + unit * 0.23),
      unit * 0.03,
      pupilPaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.12, cy + unit * 0.23),
      unit * 0.03,
      pupilPaint,
    );
    final shinePaint = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(cx - unit * 0.10, cy + unit * 0.19),
      unit * 0.02,
      shinePaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.14, cy + unit * 0.19),
      unit * 0.02,
      shinePaint,
    );

    // -- Nostrils --
    final nostrilPaint = Paint()..color = const Color(0xFF3A4A28);
    canvas.drawCircle(
      Offset(cx - unit * 0.03, cy + unit * 0.38),
      unit * 0.015,
      nostrilPaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.03, cy + unit * 0.38),
      unit * 0.015,
      nostrilPaint,
    );

    // -- Gentle smile --
    final smilePaint = Paint()
      ..color = const Color(0xFF3A4A28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = unit * 0.02
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(cx, cy + unit * 0.4),
        width: unit * 0.2,
        height: unit * 0.1,
      ),
      0.2,
      2.7,
      false,
      smilePaint,
    );
  }

  static double _cos(double radians) =>
      radians == 0 ? 1.0 : _cosLookup(radians);
  static double _sin(double radians) =>
      radians == 0 ? 0.0 : _sinLookup(radians);
  static double _cosLookup(double r) {
    // Avoid importing dart:math in the painter; inline approximation.
    // cos(x) ~ 1 - x^2/2 + x^4/24 (good enough for paint positions)
    final x = r % (2 * 3.14159265);
    final x2 = x * x;
    return 1 - x2 / 2 + x2 * x2 / 24;
  }

  static double _sinLookup(double r) {
    final x = r % (2 * 3.14159265);
    final x2 = x * x;
    return x - x2 * x / 6 + x2 * x2 * x / 120;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
