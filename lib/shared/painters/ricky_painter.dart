import 'package:flutter/material.dart';

/// Paints a simple cartoon raccoon face (Ricky).
/// Black mask markings around eyes, striped tail hint, grey/black colouring.
class RickyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final unit = size.shortestSide / 2;

    // -- Ears --
    final earPaint = Paint()..color = const Color(0xFF4A4A4A);
    final leftEar = Path()
      ..moveTo(cx - unit * 0.45, cy - unit * 0.2)
      ..lineTo(cx - unit * 0.35, cy - unit * 0.75)
      ..lineTo(cx - unit * 0.12, cy - unit * 0.35)
      ..close();
    canvas.drawPath(leftEar, earPaint);
    final rightEar = Path()
      ..moveTo(cx + unit * 0.45, cy - unit * 0.2)
      ..lineTo(cx + unit * 0.35, cy - unit * 0.75)
      ..lineTo(cx + unit * 0.12, cy - unit * 0.35)
      ..close();
    canvas.drawPath(rightEar, earPaint);
    // Inner ear
    final innerPaint = Paint()..color = const Color(0xFF787878);
    final liLeft = Path()
      ..moveTo(cx - unit * 0.40, cy - unit * 0.25)
      ..lineTo(cx - unit * 0.34, cy - unit * 0.58)
      ..lineTo(cx - unit * 0.18, cy - unit * 0.35)
      ..close();
    canvas.drawPath(liLeft, innerPaint);
    final liRight = Path()
      ..moveTo(cx + unit * 0.40, cy - unit * 0.25)
      ..lineTo(cx + unit * 0.34, cy - unit * 0.58)
      ..lineTo(cx + unit * 0.18, cy - unit * 0.35)
      ..close();
    canvas.drawPath(liRight, innerPaint);

    // -- Head --
    final headPaint = Paint()..color = const Color(0xFF8C8C8C);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy),
        width: unit * 1.2,
        height: unit * 1.15,
      ),
      headPaint,
    );

    // -- Black mask (raccoon signature) --
    final maskPaint = Paint()..color = const Color(0xFF1A1A1A);
    // Left mask patch
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - unit * 0.22, cy - unit * 0.05),
        width: unit * 0.35,
        height: unit * 0.22,
      ),
      maskPaint,
    );
    // Right mask patch
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx + unit * 0.22, cy - unit * 0.05),
        width: unit * 0.35,
        height: unit * 0.22,
      ),
      maskPaint,
    );
    // Bridge connecting the mask patches
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(cx, cy - unit * 0.12),
        width: unit * 0.15,
        height: unit * 0.1,
      ),
      maskPaint,
    );

    // -- White forehead stripe --
    final stripePaint = Paint()..color = const Color(0xFFD9D9D9);
    final stripe = Path()
      ..moveTo(cx - unit * 0.05, cy - unit * 0.5)
      ..lineTo(cx + unit * 0.05, cy - unit * 0.5)
      ..lineTo(cx + unit * 0.03, cy - unit * 0.1)
      ..lineTo(cx - unit * 0.03, cy - unit * 0.1)
      ..close();
    canvas.drawPath(stripe, stripePaint);

    // -- Eyes (inside mask) --
    final eyePaint = Paint()..color = const Color(0xFFEEEEEE);
    canvas.drawCircle(
      Offset(cx - unit * 0.2, cy - unit * 0.05),
      unit * 0.08,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.2, cy - unit * 0.05),
      unit * 0.08,
      eyePaint,
    );
    final pupilPaint = Paint()..color = const Color(0xFF111111);
    canvas.drawCircle(
      Offset(cx - unit * 0.2, cy - unit * 0.04),
      unit * 0.045,
      pupilPaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.2, cy - unit * 0.04),
      unit * 0.045,
      pupilPaint,
    );
    final shinePaint = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(cx - unit * 0.18, cy - unit * 0.07),
      unit * 0.02,
      shinePaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.22, cy - unit * 0.07),
      unit * 0.02,
      shinePaint,
    );

    // -- Light muzzle --
    final muzzlePaint = Paint()..color = const Color(0xFFD0D0D0);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy + unit * 0.2),
        width: unit * 0.4,
        height: unit * 0.35,
      ),
      muzzlePaint,
    );

    // -- Nose --
    final nosePaint = Paint()..color = const Color(0xFF111111);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy + unit * 0.12),
        width: unit * 0.1,
        height: unit * 0.07,
      ),
      nosePaint,
    );

    // -- Mouth --
    final mouthPaint = Paint()
      ..color = const Color(0xFF333333)
      ..style = PaintingStyle.stroke
      ..strokeWidth = unit * 0.02
      ..strokeCap = StrokeCap.round;
    final mouth = Path()
      ..moveTo(cx, cy + unit * 0.16)
      ..lineTo(cx - unit * 0.06, cy + unit * 0.24)
      ..moveTo(cx, cy + unit * 0.16)
      ..lineTo(cx + unit * 0.06, cy + unit * 0.24);
    canvas.drawPath(mouth, mouthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
