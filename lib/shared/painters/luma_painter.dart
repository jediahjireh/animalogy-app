import 'package:flutter/material.dart';

/// Paints a simple cartoon capybara face (Luma).
/// Large rounded blocky head, small ears on top, brown, friendly eyes.
class LumaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final unit = size.shortestSide / 2;

    // -- Small rounded ears --
    final earPaint = Paint()..color = const Color(0xFF6B4E35);
    canvas.drawCircle(
      Offset(cx - unit * 0.4, cy - unit * 0.45),
      unit * 0.13,
      earPaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.4, cy - unit * 0.45),
      unit * 0.13,
      earPaint,
    );
    final innerEarPaint = Paint()..color = const Color(0xFFA07558);
    canvas.drawCircle(
      Offset(cx - unit * 0.4, cy - unit * 0.45),
      unit * 0.07,
      innerEarPaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.4, cy - unit * 0.45),
      unit * 0.07,
      innerEarPaint,
    );

    // -- Large blocky head --
    final headPaint = Paint()..color = const Color(0xFF8B6B4A);
    final headRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, cy),
        width: unit * 1.2,
        height: unit * 1.3,
      ),
      Radius.circular(unit * 0.35),
    );
    canvas.drawRRect(headRect, headPaint);

    // -- Lighter muzzle (wide, flat) --
    final muzzlePaint = Paint()..color = const Color(0xFFBFA07A);
    final muzzleRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, cy + unit * 0.25),
        width: unit * 0.8,
        height: unit * 0.5,
      ),
      Radius.circular(unit * 0.2),
    );
    canvas.drawRRect(muzzleRect, muzzlePaint);

    // -- Eyes (friendly, slightly droopy) --
    final eyeWhite = Paint()..color = const Color(0xFFFFF5E6);
    canvas.drawCircle(
      Offset(cx - unit * 0.22, cy - unit * 0.1),
      unit * 0.1,
      eyeWhite,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.22, cy - unit * 0.1),
      unit * 0.1,
      eyeWhite,
    );
    final irisPaint = Paint()..color = const Color(0xFF3E2B1A);
    canvas.drawCircle(
      Offset(cx - unit * 0.22, cy - unit * 0.08),
      unit * 0.065,
      irisPaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.22, cy - unit * 0.08),
      unit * 0.065,
      irisPaint,
    );
    final pupilPaint = Paint()..color = const Color(0xFF111111);
    canvas.drawCircle(
      Offset(cx - unit * 0.22, cy - unit * 0.07),
      unit * 0.035,
      pupilPaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.22, cy - unit * 0.07),
      unit * 0.035,
      pupilPaint,
    );
    final shinePaint = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(cx - unit * 0.19, cy - unit * 0.12),
      unit * 0.025,
      shinePaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.25, cy - unit * 0.12),
      unit * 0.025,
      shinePaint,
    );

    // -- Nostrils --
    final nostrilPaint = Paint()..color = const Color(0xFF4A3728);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - unit * 0.06, cy + unit * 0.18),
        width: unit * 0.06,
        height: unit * 0.04,
      ),
      nostrilPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx + unit * 0.06, cy + unit * 0.18),
        width: unit * 0.06,
        height: unit * 0.04,
      ),
      nostrilPaint,
    );

    // -- Friendly smile --
    final smilePaint = Paint()
      ..color = const Color(0xFF4A3728)
      ..style = PaintingStyle.stroke
      ..strokeWidth = unit * 0.025
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(cx, cy + unit * 0.3),
        width: unit * 0.35,
        height: unit * 0.18,
      ),
      0.2,
      2.7,
      false,
      smilePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
