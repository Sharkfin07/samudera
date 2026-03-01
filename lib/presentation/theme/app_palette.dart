import 'package:flutter/material.dart';

class AppPalette {
  // * Hex Code to Color Converter
  static Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '').toUpperCase();
    return Color(int.parse('FF$hex', radix: 16));
  }

  // * Main Palettes
  static final vividBlue = _hexToColor("#0a6cff");
  static final purple = _hexToColor("#8c52ff");
  static final vividIndigo = _hexToColor("#1800ad");
  static final darkIndigo = _hexToColor("#10073d");
  static final lightIndigo = _hexToColor("#f5f0ff");

  // * Gradients
  static final primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment(0.8, 1),
    colors: <Color>[vividBlue, vividIndigo, purple],
    tileMode: TileMode.mirror,
  );
}
