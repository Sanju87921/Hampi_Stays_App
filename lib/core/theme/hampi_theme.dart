import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HampiTheme {
  // 🎨 Color System (The "Earth & Stone" Palette)
  static const Color warmIvory = Color(0xFFFDFBF7);
  static const Color sandstone = Color(0xFFF3EFE7);
  static const Color mutedGold = Color(0xFFC8A96B);
  static const Color deepNavy = Color(0xFF020617);
  static const Color heritageCream = Color(0xFFFAF7F2);
  static const Color clayRed = Color(0xFF92400E);

  // Success/Premium Gradient colors
  static const List<Color> luxuryGoldGradient = [
    Color(0xFFC8A96B),
    Color(0xFFD4AF37),
    Color(0xFFB8860B),
  ];

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: warmIvory,
      primaryColor: mutedGold,
      colorScheme: ColorScheme.fromSeed(
        seedColor: mutedGold,
        primary: mutedGold,
        onPrimary: warmIvory,
        secondary: deepNavy,
        surface: sandstone,
        onSurface: deepNavy,
        background: warmIvory,
        error: clayRed,
      ),
      
      // ✍️ Typography System
      textTheme: TextTheme(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: deepNavy,
          letterSpacing: -0.02 * 42,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: deepNavy,
          letterSpacing: -0.01 * 32,
        ),
        headlineMedium: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: deepNavy.withOpacity(0.6),
          letterSpacing: 0.2 * 14,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: deepNavy,
          letterSpacing: 0.01 * 16,
        ),
        bodySmall: GoogleFonts.outfit(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: deepNavy.withOpacity(0.8),
          letterSpacing: 0.02 * 13,
        ),
        labelLarge: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: warmIvory,
          letterSpacing: 0.1 * 14,
        ),
      ),

      // UI Style Guide (Depth & Radius)
      cardTheme: CardTheme(
        color: sandstone,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: deepNavy,
          foregroundColor: warmIvory,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.1 * 14,
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: heritageCream,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: mutedGold, width: 1),
        ),
        labelStyle: GoogleFonts.outfit(color: deepNavy.withOpacity(0.5)),
        hintStyle: GoogleFonts.outfit(color: deepNavy.withOpacity(0.3)),
      ),
    );
  }

  // 🎬 Luxury Curve
  static const Curve luxuryCurve = Cubic(0.16, 1, 0.3, 1);
}
