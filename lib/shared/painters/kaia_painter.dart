import 'package:flutter/material.dart';

/// Paints a simple cartoon meerkat face (Kaia).
/// Triangular face, big dark eyes, small rounded ears, sandy brown colour.
class KaiaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final unit = size.shortestSide / 2;

    // -- Ears (behind face) --
    final earPaint = Paint()..color = const Color(0xFFC4A265);
    canvas.drawCircle(
      Offset(cx - unit * 0.35, cy - unit * 0.55),
      unit * 0.18,
      earPaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.35, cy - unit * 0.55),
      unit * 0.18,
      earPaint,
    );
    final innerEarPaint = Paint()..color = const Color(0xFFE8C98A);
    canvas.drawCircle(
      Offset(cx - unit * 0.35, cy - unit * 0.55),
      unit * 0.10,
      innerEarPaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.35, cy - unit * 0.55),
      unit * 0.10,
      innerEarPaint,
    );

    // -- Head (tapered oval, narrower at chin) --
    final headPaint = Paint()..color = const Color(0xFFD4AC6E);
    final headPath = Path()
      ..moveTo(cx, cy - unit * 0.7)
      ..quadraticBezierTo(
        cx + unit * 0.55,
        cy - unit * 0.3,
        cx + unit * 0.4,
        cy + unit * 0.2,
      )
      ..quadraticBezierTo(
        cx + unit * 0.15,
        cy + unit * 0.65,
        cx,
        cy + unit * 0.7,
      )
      ..quadraticBezierTo(
        cx - unit * 0.15,
        cy + unit * 0.65,
        cx - unit * 0.4,
        cy + unit * 0.2,
      )
      ..quadraticBezierTo(
        cx - unit * 0.55,
        cy - unit * 0.3,
        cx,
        cy - unit * 0.7,
      )
      ..close();
    canvas.drawPath(headPath, headPaint);

    // -- Lighter muzzle area --
    final muzzlePaint = Paint()..color = const Color(0xFFE8D5A8);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy + unit * 0.15),
        width: unit * 0.45,
        height: unit * 0.5,
      ),
      muzzlePaint,
    );

    // -- Eyes (big and dark) --
    final eyePaint = Paint()..color = const Color(0xFF1A1A1A);
    canvas.drawCircle(
      Offset(cx - unit * 0.18, cy - unit * 0.1),
      unit * 0.11,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.18, cy - unit * 0.1),
      unit * 0.11,
      eyePaint,
    );
    // Eye shine
    final shinePaint = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(cx - unit * 0.15, cy - unit * 0.14),
      unit * 0.035,
      shinePaint,
    );
    canvas.drawCircle(
      Offset(cx + unit * 0.21, cy - unit * 0.14),
      unit * 0.035,
      shinePaint,
    );

    // -- Dark eye patches (meerkat markings) --
    final patchPaint = Paint()
      ..color = const Color(0xFF6B4E2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = unit * 0.04;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(cx - unit * 0.18, cy - unit * 0.1),
        width: unit * 0.32,
        height: unit * 0.3,
      ),
      0.3,
      3.0,
      false,
      patchPaint,
    );
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(cx + unit * 0.18, cy - unit * 0.1),
        width: unit * 0.32,
        height: unit * 0.3,
      ),
      -0.3,
      -3.0,
      false,
      patchPaint,
    );

    // -- Nose --
    final nosePaint = Paint()..color = const Color(0xFF2C2C2C);
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
      ..color = const Color(0xFF5C4326)
      ..style = PaintingStyle.stroke
      ..strokeWidth = unit * 0.025
      ..strokeCap = StrokeCap.round;
    final mouthPath = Path()
      ..moveTo(cx - unit * 0.06, cy + unit * 0.22)
      ..quadraticBezierTo(
        cx,
        cy + unit * 0.28,
        cx + unit * 0.06,
        cy + unit * 0.22,
      );
    canvas.drawPath(mouthPath, mouthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
