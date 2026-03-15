import 'package:flutter/material.dart';

/// Application color constants.
///
/// This class contains all color values used throughout the app.
/// Colors are organized by usage category for easy maintenance.
abstract class AppColors {
  // Primary colors
  static const secondary = Color(0xFF3B76F6);
  static const accent = Color(0xFFD6755B);

  // Text colors
  static const textDark = Color(0xFF53585A);
  static const textLight = Color(0xFFF5F5F5);
  static const textFaded = Color(0xFF9899A5);
  static const textHighlight = secondary;

  // Icon colors
  static const iconLight = Color(0xFFB1B4C0);
  static const iconDark = Color(0xFFB1B3C1);

  // Card colors
  static const cardLight = Color(0xFFF9FAFE);
  static const cardDark = Color(0xFF303334);

  // Background colors
  static const backgroundLight = Colors.white;
  static const backgroundDark = Color(0xFF1B1E1F);
}
