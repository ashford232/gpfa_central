import 'package:flutter/material.dart';

Color userColor(String id) {
  final hash = id.hashCode & 0x7FFFFFFF;

  final hue = (hash % 360).toDouble();

  return HSLColor.fromAHSL(1.0, hue, 0.65, 0.50).toColor();
}
