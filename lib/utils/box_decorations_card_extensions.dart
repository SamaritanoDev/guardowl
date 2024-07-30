import 'package:flutter/material.dart';

extension BoxDecorationCardExtension on BoxDecoration {
  static BoxDecoration cardBorders(double radius, Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
