import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The Ovens Secret Design System
/// Ported 1:1 from the Next.js Tailwind CSS design
class AppColors {
  // Primary
  static const Color primaryRed = Color(0xFFC0392B);
  static const Color primaryRedHover = Color(0xFFA52A1A);
  static const Color deepBurgundy = Color(0xFF7B1F1F);

  // Browns
  static const Color darkBrown = Color(0xFF783D19);
  static const Color warmBrownText = Color(0xFF5C2D1E);
  static const Color sienna = Color(0xFFA0522D);
  static const Color saddleBrown = Color(0xFF8B4513);

  // Backgrounds
  static const Color creamBackground = Color(0xFFFDF6EE);
  static const Color warmAccent = Color(0xFFFAEBD7);
  static const Color lightAmber = Color(0xFFFFF8F0);
  static const Color amber50 = Color(0xFFFFFBEB);
  static const Color orange50 = Color(0xFFFFF7ED);

  // Borders
  static const Color borderGold = Color(0xFFF0DDC0);
  static const Color borderRich = Color(0xFFE8D5B0);
  static const Color borderAmber = Color(0xFFE8C9A0);

  // Accent
  static const Color pinkAccent = Color(0xFFF9C5B5);
  static const Color peachAccent = Color(0xFFFCD9CE);
  static const Color whatsAppGreen = Color(0xFF25D366);

  // Neutral
  static const Color white = Colors.white;
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color stone100 = Color(0xFFF5F5F4);
  static const Color stone200 = Color(0xFFE7E5E4);
  static const Color stone300 = Color(0xFFD6D3D1);
  static const Color stone500 = Color(0xFF78716C);
  static const Color stone700 = Color(0xFF44403C);
  static const Color stone800 = Color(0xFF292524);
  static const Color stone900 = Color(0xFF1C1917);

  // Amber
  static const Color amber100 = Color(0xFFFEF3C7);
  static const Color amber200 = Color(0xFFFDE68A);
  static const Color amber300 = Color(0xFFFCD34D);
  static const Color amber400 = Color(0xFFFBBF24);
  static const Color amber500 = Color(0xFFF59E0B);
  static const Color amber600 = Color(0xFFD97706);
  static const Color amber700 = Color(0xFFB45309);
  static const Color amber800 = Color(0xFF92400E);
  static const Color amber900 = Color(0xFF78350F);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.creamBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryRed,
        brightness: Brightness.light,
        primary: AppColors.primaryRed,
        onPrimary: Colors.white,
        surface: AppColors.creamBackground,
        onSurface: AppColors.warmBrownText,
      ),
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: AppColors.warmBrownText,
        displayColor: AppColors.deepBurgundy,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBrown,
        foregroundColor: AppColors.stone200,
        elevation: 4,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryRed,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 4,
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryRed,
          side: const BorderSide(color: AppColors.primaryRed, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.amber900, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: TextStyle(color: AppColors.gray500),
      ),
    );
  }
}
