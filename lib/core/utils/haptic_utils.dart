import 'package:flutter/services.dart';

class HapticUtils {
  HapticUtils._();

  static void lightTap() => HapticFeedback.lightImpact();

  static void mediumTap() => HapticFeedback.mediumImpact();

  static void heavyTap() => HapticFeedback.heavyImpact();

  static void selection() => HapticFeedback.selectionClick();

  static void success() => HapticFeedback.mediumImpact();

  static void error() => HapticFeedback.heavyImpact();
}
