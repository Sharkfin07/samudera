import 'package:flutter/material.dart';
import 'package:samudera/presentation/theme/app_palette.dart';

class AppTheme {
  // * Font Families
  static const String fontHeading = 'Garet';
  static const String fontBody = 'IBMPlexSans';

  // * Light Theme
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppPalette.vividBlue,
    scaffoldBackgroundColor: AppPalette.lightIndigo,
    colorScheme: ColorScheme.light(
      primary: AppPalette.vividBlue,
      secondary: AppPalette.purple,
      tertiary: AppPalette.vividIndigo,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppPalette.darkIndigo,
    ),
    fontFamily: fontBody,
    textTheme: _textTheme(AppPalette.darkIndigo),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: fontHeading,
        fontWeight: FontWeight.w900,
        fontSize: 20,
        color: AppPalette.darkIndigo,
      ),
      iconTheme: IconThemeData(color: AppPalette.darkIndigo),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shadowColor: AppPalette.vividIndigo.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.vividBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: fontBody,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppPalette.vividBlue,
        side: BorderSide(color: AppPalette.vividBlue, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: fontBody,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppPalette.vividBlue,
        textStyle: const TextStyle(
          fontFamily: fontBody,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppPalette.vividBlue, width: 2),
      ),
      hintStyle: TextStyle(
        fontFamily: fontBody,
        color: Colors.grey.shade400,
        fontWeight: FontWeight.w400,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppPalette.vividBlue,
      unselectedItemColor: Colors.grey.shade400,
      selectedLabelStyle: const TextStyle(
        fontFamily: fontBody,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: fontBody,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppPalette.lightIndigo,
      selectedColor: AppPalette.vividBlue,
      labelStyle: TextStyle(
        fontFamily: fontBody,
        fontWeight: FontWeight.w500,
        color: AppPalette.darkIndigo,
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: fontBody,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    dividerTheme: DividerThemeData(color: Colors.grey.shade200, thickness: 1),
  );

  // * Dark Theme
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppPalette.vividBlue,
    scaffoldBackgroundColor: AppPalette.darkIndigo,
    colorScheme: ColorScheme.dark(
      primary: AppPalette.vividBlue,
      secondary: AppPalette.purple,
      tertiary: AppPalette.vividIndigo,
      surface: const Color.fromARGB(255, 10, 8, 13),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
    ),
    fontFamily: fontBody,
    textTheme: _textTheme(Colors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: fontHeading,
        fontWeight: FontWeight.w900,
        fontSize: 20,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF1A1035),
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.vividBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: fontBody,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppPalette.vividBlue,
        side: BorderSide(color: AppPalette.vividBlue, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: fontBody,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppPalette.vividBlue,
        textStyle: const TextStyle(
          fontFamily: fontBody,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A1035),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppPalette.vividBlue, width: 2),
      ),
      hintStyle: TextStyle(
        fontFamily: fontBody,
        color: Colors.white.withValues(alpha: 0.4),
        fontWeight: FontWeight.w400,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1A1035),
      selectedItemColor: AppPalette.vividBlue,
      unselectedItemColor: Colors.white.withValues(alpha: 0.4),
      selectedLabelStyle: const TextStyle(
        fontFamily: fontBody,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: fontBody,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF1A1035),
      selectedColor: AppPalette.vividBlue,
      labelStyle: const TextStyle(
        fontFamily: fontBody,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: fontBody,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.white.withValues(alpha: 0.1),
      thickness: 1,
    ),
  );

  // * Text Theme (shared structure, different colors)
  static TextTheme _textTheme(Color textColor) => TextTheme(
    // Display styles - Garet Heavy
    displayLarge: TextStyle(
      fontFamily: fontHeading,
      fontWeight: FontWeight.w900,
      fontSize: 57,
      color: textColor,
    ),
    displayMedium: TextStyle(
      fontFamily: fontHeading,
      fontWeight: FontWeight.w900,
      fontSize: 45,
      color: textColor,
    ),
    displaySmall: TextStyle(
      fontFamily: fontHeading,
      fontWeight: FontWeight.w900,
      fontSize: 36,
      color: textColor,
    ),

    // Headline styles - Garet Heavy
    headlineLarge: TextStyle(
      fontFamily: fontHeading,
      fontWeight: FontWeight.w900,
      fontSize: 32,
      color: textColor,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontHeading,
      fontWeight: FontWeight.w900,
      fontSize: 28,
      color: textColor,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontHeading,
      fontWeight: FontWeight.w900,
      fontSize: 24,
      color: textColor,
    ),

    // Title styles - IBMPlexSans SemiBold/Medium
    titleLarge: TextStyle(
      fontFamily: fontBody,
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: textColor,
    ),
    titleMedium: TextStyle(
      fontFamily: fontBody,
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: textColor,
    ),
    titleSmall: TextStyle(
      fontFamily: fontBody,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: textColor,
    ),

    // Body styles - IBMPlexSans Regular/Medium
    bodyLarge: TextStyle(
      fontFamily: fontBody,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: textColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontBody,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: textColor,
    ),
    bodySmall: TextStyle(
      fontFamily: fontBody,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: textColor.withValues(alpha: 0.7),
    ),

    // Label styles - IBMPlexSans Medium
    labelLarge: TextStyle(
      fontFamily: fontBody,
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: textColor,
    ),
    labelMedium: TextStyle(
      fontFamily: fontBody,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: textColor,
    ),
    labelSmall: TextStyle(
      fontFamily: fontBody,
      fontWeight: FontWeight.w500,
      fontSize: 11,
      color: textColor.withValues(alpha: 0.7),
    ),
  );
}
