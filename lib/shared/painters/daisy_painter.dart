import 'package:flutter/material.dart';

/// Paints a simple cartoon dingo face (Daisy).
/// Pointed triangular ears, long golden snout, dark nose, amber eyes.
class DaisyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final unit = size.shortestSide / 2;

    // -- Pointed ears --
    final earPaint = Paint()..color = const Color(0xFFD4952B);
    final leftEar = Path()
      ..moveTo(cx - unit * 0.45, cy - unit * 0.15)
      ..lineTo(cx - unit * 0.3, cy - unit * 0.85)
      ..lineTo(cx - unit * 0.1, cy - unit * 0.3)
      ..close();
    canvas.drawPath(leftEar, earPaint);
    final rightEar = Path()
      ..moveTo(cx + unit * 0.45, cy - unit * 0.15)
      ..lineTo(cx + unit * 0.3, cy - unit * 0.85)
      ..lineTo(cx + unit * 0.1, cy - unit * 0.3)
      ..close();
    canvas.drawPath(rightEar, earPaint);

    // Inner ear
    final innerEarPaint = Paint()..color = const Color(0xFFE8BA6A);
    final leftInner = Path()
      ..moveTo(cx - unit * 0.38, cy - unit * 0.2)
      ..lineTo(cx - unit * 0.3, cy - unit * 0.65)
      ..lineTo(cx - unit * 0.15, cy - unit * 0.3)
      ..close();
    canvas.drawPath(leftInner, innerEarPaint);
    final rightInner = Path()
      ..moveTo(cx + unit * 0.38, cy - unit * 0.2)
      ..lineTo(cx + unit * 0.3, cy - unit * 0.65)
      ..lineTo(cx + unit * 0.15, cy - unit * 0.3)
      ..close();
    canvas.drawPath(rightInner, innerEarPaint);

    // -- Head --
    final headPaint = Paint()..color = const Color(0xFFD4952B);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy),
        width: unit * 1.1,
        height: unit * 1.2,
      ),
      headPaint,
    );

    // -- Snout (elongated) --
    final snoutPaint = Paint()..color = const Color(0xFFEACB8E);
    final snoutPath = Path()
      ..moveTo(cx - unit * 0.22, cy + unit * 0.05)
      ..quadraticBezierTo(
        cx - unit * 0.18,
        cy + unit * 0.55,
        cx,
        cy + unit * 0.65,
      )
      ..quadraticBezierTo(
        cx + unit * 0.18,
        cy + unit * 0.55,
        cx + unit * 0.22,
        cy + unit * 0.05,
      )
      ..close();
    canvas.drawPath(snoutPath, snoutPaint);

    // -- Eyes (amber) --
    final eyeWhite = Paint()..color = const Color(0xFFFFF8E7);
    canvas.drawCircle(
      Offset(cx - unit * 0.2, cy - unit * 0.1),
      unit * 0.12,
      eyeWhite,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.2, cy - unit * 0.1),
      unit * 0.12,
      eyeWhite,
    );
    final irisPaint = Paint()..color = const Color(0xFFCC7722);
    canvas.drawCircle(
      Offset(cx - unit * 0.2, cy - unit * 0.08),
      unit * 0.08,
      irisPaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.2, cy - unit * 0.08),
      unit * 0.08,
      irisPaint,
    );
    final pupilPaint = Paint()..color = const Color(0xFF1A1A1A);
    canvas.drawCircle(
      Offset(cx - unit * 0.2, cy - unit * 0.07),
      unit * 0.04,
      pupilPaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.2, cy - unit * 0.07),
      unit * 0.04,
      pupilPaint,
    );
    final shinePaint = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(cx - unit * 0.17, cy - unit * 0.12),
      unit * 0.025,
      shinePaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.23, cy - unit * 0.12),
      unit * 0.025,
      shinePaint,
    );

    // -- Nose --
    final nosePaint = Paint()..color = const Color(0xFF1A1A1A);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy + unit * 0.2),
        width: unit * 0.14,
        height: unit * 0.1,
      ),
      nosePaint,
    );

    // -- Mouth --
    final mouthPaint = Paint()
      ..color = const Color(0xFF5C4326)
      ..style = PaintingStyle.stroke
      ..strokeWidth = unit * 0.025
      ..strokeCap = StrokeCap.round;
    final mouth = Path()
      ..moveTo(cx, cy + unit * 0.26)
      ..lineTo(cx - unit * 0.08, cy + unit * 0.34)
      ..moveTo(cx, cy + unit * 0.26)
      ..lineTo(cx + unit * 0.08, cy + unit * 0.34);
    canvas.drawPath(mouth, mouthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
