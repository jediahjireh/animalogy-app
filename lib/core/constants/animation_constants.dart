import 'package:flutter/animation.dart';

class AnimationDurations {
  AnimationDurations._();

  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 250);
  static const slow = Duration(milliseconds: 400);
  static const pageTransition = Duration(milliseconds: 300);
  static const celebration = Duration(milliseconds: 600);
}

class AnimationCurves {
  AnimationCurves._();

  static const bounce = Curves.bounceOut;
  static const smooth = Curves.easeInOutCubic;
  static const enter = Curves.easeOutCubic;
  static const exit = Curves.easeInCubic;
  static const overshoot = Curves.elasticOut;
}
