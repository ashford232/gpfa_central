import 'package:flutter/material.dart';

extension ColorTextColor on Color {
  Color get appropriateTextColor {
    return computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}

extension StringCapitalization on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
