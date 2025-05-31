import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkTheme {
  static const Color primaryColor = Color(0xFF7C3AED); // Vibrant purple
  static const Color accentColor = Color(0xFF2DD4BF); // Calming teal
  static const Color backgroundColor = Color(0xFF121212); // Dark background
  static const Color whiteColor = Color(0xFF1E1E1E); // Dark gray for surfaces
  static const Color textColor = Color(0xFFFFFFFF); // Pure white text
  static const Color secondaryTextColor = Color(0xFFFFFFFF); // Pure white for secondary text
  static const Color sidebarColor = Color(0xFF1E1E1E); // Match surface color
  static const Color errorColor = Color(0xFFFF5555); // Softer red

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: accentColor,
        error: errorColor,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        bodyLarge: const TextStyle(color: textColor),
        bodyMedium: const TextStyle(color: textColor),
        labelLarge: const TextStyle(color: textColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentColor,
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10,
        ),
        hintStyle: GoogleFonts.poppins(
          fontSize: 12,
          color: textColor, // Use pure white for hints in dark mode
        ),
      ),
      cardTheme: CardThemeData(
        color: whiteColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: whiteColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: primaryColor,
        contentTextStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: sidebarColor,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: textColor,
        textColor: textColor,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        subtitleTextStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textColor, // Use pure white for subtitles
        ),
      ),
    );
  }
}