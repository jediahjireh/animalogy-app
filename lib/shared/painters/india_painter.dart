import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Paints an Indian landscape background.
/// Green/gold gradient with lotus flower and banyan leaf silhouettes.
class IndiaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // -- Background gradient (green to gold) --
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF2D6B3E), Color(0xFF6B8E3A), Color(0xFFD4A847)],
        stops: [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    // -- Water strip at bottom --
    final waterPaint = Paint()
      ..color = const Color(0xFF3A7D6B).withValues(alpha: 0.5);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.82, w, h * 0.18), waterPaint);

    // -- Lotus flower (centre-bottom) --
    _drawLotus(canvas, w * 0.5, h * 0.78, w * 0.12);

    // -- Smaller lotus --
    _drawLotus(canvas, w * 0.2, h * 0.85, w * 0.06);
    _drawLotus(canvas, w * 0.8, h * 0.88, w * 0.05);

    // -- Banyan leaf silhouettes (top area) --
    final leafPaint = Paint()
      ..color = const Color(0xFF1A4D2E).withValues(alpha: 0.4);
    _drawBanyanLeaf(canvas, w * 0.15, h * 0.1, w * 0.14, leafPaint);
    _drawBanyanLeaf(canvas, w * 0.85, h * 0.15, w * 0.12, leafPaint);
    _drawBanyanLeaf(canvas, w * 0.6, h * 0.05, w * 0.1, leafPaint);

    // -- Floating lily pads --
    final lilyPaint = Paint()
      ..color = const Color(0xFF4A8C5E).withValues(alpha: 0.45);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.35, h * 0.9),
        width: w * 0.08,
        height: h * 0.02,
      ),
      lilyPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.65, h * 0.92),
        width: w * 0.06,
        height: h * 0.015,
      ),
      lilyPaint,
    );

    // -- Decorative sun glow --
    final glowPaint = Paint()
      ..color = const Color(0xFFFFD700).withValues(alpha: 0.25);
    canvas.drawCircle(Offset(w * 0.5, h * 0.2), w * 0.15, glowPaint);
  }

  /// Draws a simplified lotus flower with petal arcs.
  void _drawLotus(Canvas canvas, double cx, double cy, double petalLen) {
    final petalPaint = Paint()
      ..color = const Color(0xFFE8A0B0).withValues(alpha: 0.7);
    const petalCount = 5;
    for (int i = 0; i < petalCount; i++) {
      final angle = -math.pi + (math.pi / (petalCount - 1)) * i;
      final path = Path()
        ..moveTo(cx, cy)
        ..quadraticBezierTo(
          cx + petalLen * 0.5 * math.cos(angle - 0.3),
          cy + petalLen * math.sin(angle),
          cx + petalLen * math.cos(angle),
          cy + petalLen * math.sin(angle) * 0.6,
        )
        ..quadraticBezierTo(
          cx + petalLen * 0.5 * math.cos(angle + 0.3),
          cy + petalLen * math.sin(angle),
          cx,
          cy,
        );
      canvas.drawPath(path, petalPaint);
    }
    // Centre dot
    final centrePaint = Paint()..color = const Color(0xFFD4A847);
    canvas.drawCircle(Offset(cx, cy), petalLen * 0.15, centrePaint);
  }

  /// Draws a broad banyan/tropical leaf silhouette.
  void _drawBanyanLeaf(
    Canvas canvas,
    double cx,
    double cy,
    double leafSize,
    Paint paint,
  ) {
    final path = Path()
      ..moveTo(cx, cy - leafSize * 0.6)
      ..quadraticBezierTo(
        cx + leafSize * 0.6,
        cy - leafSize * 0.1,
        cx + leafSize * 0.1,
        cy + leafSize * 0.5,
      )
      ..quadraticBezierTo(
        cx,
        cy + leafSize * 0.3,
        cx - leafSize * 0.1,
        cy + leafSize * 0.5,
      )
      ..quadraticBezierTo(
        cx - leafSize * 0.6,
        cy - leafSize * 0.1,
        cx,
        cy - leafSize * 0.6,
      )
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
