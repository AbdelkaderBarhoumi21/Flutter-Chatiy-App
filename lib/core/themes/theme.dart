import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chatiy_app/core/utils/constans/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Application theme manager using Singleton pattern.
///
/// This class provides centralized theme management for the entire application.
/// It uses the Singleton pattern to ensure only one instance exists throughout
/// the app lifecycle.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.instance.light,
///   darkTheme: AppTheme.instance.dark,
/// )
/// ```
class AppTheme {
  // Private constructor
  AppTheme._();

  // Singleton instance
  static final AppTheme _instance = AppTheme._();

  /// Access the singleton instance
  static AppTheme get instance => _instance;

  // Theme configuration constants
  static const _accentColor = AppColors.accent;
  static final _visualDensity = VisualDensity.adaptivePlatformDensity;
  static final _lightBase = ThemeData.light();
  static final _darkBase = ThemeData.dark();

  /// Light theme configuration.
  ///
  /// Provides a complete Material Design light theme with custom colors,
  /// typography using Mulish font, and transparent app bar.
  ThemeData get light => ThemeData(
        brightness: Brightness.light,
        colorScheme: _lightBase.colorScheme.copyWith(secondary: _accentColor),
        visualDensity: _visualDensity,
        textTheme: GoogleFonts.mulishTextTheme().apply(
          bodyColor: AppColors.textDark,
        ),
        appBarTheme: _lightBase.appBarTheme.copyWith(
          iconTheme: _lightBase.iconTheme,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: AppColors.textDark,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
        ),
        scaffoldBackgroundColor: AppColors.backgroundLight,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
          ),
        ),
        cardColor: AppColors.cardLight,
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(color: AppColors.textDark),
        ),
        iconTheme: const IconThemeData(color: AppColors.iconDark),
      );

  /// Dark theme configuration.
  ///
  /// Provides a complete Material Design dark theme with custom colors,
  /// typography using Inter font, and transparent app bar.
  ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        colorScheme: _darkBase.colorScheme.copyWith(secondary: _accentColor),
        visualDensity: _visualDensity,
        textTheme: GoogleFonts.interTextTheme().apply(
          bodyColor: AppColors.textLight,
        ),
        appBarTheme: _darkBase.appBarTheme.copyWith(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
        ),
        scaffoldBackgroundColor: AppColors.backgroundDark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
          ),
        ),
        cardColor: AppColors.cardDark,
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(color: AppColors.textLight),
        ),
        iconTheme: const IconThemeData(color: AppColors.iconLight),
      );
}
