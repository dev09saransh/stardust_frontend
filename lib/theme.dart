import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ─── Premium Palette ───
  static const Color darkBg = Color(0xFF0A0A1A);          
  static const Color darkSurface = Color(0xFF12122A);      
  static const Color deepCharcoal = Color(0xFF1A1A2E);     
  static const Color silverMist = Color(0xFFD0CFFF);       
  static const Color platinum = Color(0xFFF0EEFF);         
  static const Color lavenderAccent = Color(0xFF2196F3);   
  static const Color softPurple = Color(0xFF6C63FF);       
  static const Color surfaceGlass = Color(0x14FFFFFF);     
  static const Color borderSubtle = Color(0x1AFFFFFF);     

  // Iridescent / Silver-Mist Palette for card borders
  static const List<Color> iridescentColors = [
    Color(0xFF2196F3), // Primary Blue
    Color(0xFFA2D2FF), // Sky Blue
    Color(0xFFB8C0FF), // Lavender
    Color(0xFFC8B6FF), // Soft Purple
    Color(0xFFE7C6FF), // Pale Pink
    Color(0xFF2196F3), // Back to Blue
  ];

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static ThemeData get darkTheme {
    final baseTheme = ThemeData.dark();
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: lavenderAccent,
      colorScheme: const ColorScheme.dark(
        primary: lavenderAccent,
        secondary: softPurple,
        surface: deepCharcoal,
        onPrimary: Colors.white,
        onSurface: platinum,
        onSurfaceVariant: silverMist,
      ),
      textTheme: GoogleFonts.outfitTextTheme(baseTheme.textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(textStyle: baseTheme.textTheme.displayLarge, fontWeight: FontWeight.w900, color: platinum),
        displayMedium: GoogleFonts.outfit(textStyle: baseTheme.textTheme.displayMedium, fontWeight: FontWeight.w900, color: platinum),
        displaySmall: GoogleFonts.outfit(textStyle: baseTheme.textTheme.displaySmall, fontWeight: FontWeight.w900, color: platinum),
        headlineLarge: GoogleFonts.outfit(textStyle: baseTheme.textTheme.headlineLarge, fontWeight: FontWeight.w900, color: platinum),
        headlineMedium: GoogleFonts.outfit(textStyle: baseTheme.textTheme.headlineMedium, fontWeight: FontWeight.bold, color: platinum),
        titleLarge: GoogleFonts.outfit(textStyle: baseTheme.textTheme.titleLarge, fontWeight: FontWeight.bold, color: platinum),
        bodyLarge: GoogleFonts.inter(textStyle: baseTheme.textTheme.bodyLarge, fontWeight: FontWeight.w700, color: platinum),
        bodyMedium: GoogleFonts.inter(textStyle: baseTheme.textTheme.bodyMedium, fontWeight: FontWeight.w700, color: silverMist),
        bodySmall: GoogleFonts.inter(textStyle: baseTheme.textTheme.bodySmall, fontWeight: FontWeight.w700, color: silverMist),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: platinum),
      ),
    );
  }

  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light();
    const Color lightBluePrimary = Color(0xFF2196F3);
    const Color mistBg = Color(0xFFF0F4FF); // Custom Stardust Mist tint
    const Color extremeDark = Color(0xFF0D0D1A); // Darker black for text classiness

    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: mistBg,
      primaryColor: lightBluePrimary,
      colorScheme: const ColorScheme.light(
        primary: lightBluePrimary,
        secondary: Color(0xFF9C27B0),
        surface: Colors.white,
        onPrimary: Colors.white,
        onSurface: extremeDark,
        onSurfaceVariant: Color(0xFF4A4A6A),
        surfaceTint: Colors.white,
      ),
      textTheme: GoogleFonts.outfitTextTheme(baseTheme.textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(textStyle: baseTheme.textTheme.displayLarge, fontWeight: FontWeight.w900, color: extremeDark),
        displayMedium: GoogleFonts.outfit(textStyle: baseTheme.textTheme.displayMedium, fontWeight: FontWeight.w900, color: extremeDark),
        displaySmall: GoogleFonts.outfit(textStyle: baseTheme.textTheme.displaySmall, fontWeight: FontWeight.w900, color: extremeDark),
        headlineLarge: GoogleFonts.outfit(textStyle: baseTheme.textTheme.headlineLarge, fontWeight: FontWeight.w900, color: extremeDark),
        headlineMedium: GoogleFonts.outfit(textStyle: baseTheme.textTheme.headlineMedium, fontWeight: FontWeight.bold, color: extremeDark),
        titleLarge: GoogleFonts.outfit(textStyle: baseTheme.textTheme.titleLarge, fontWeight: FontWeight.bold, color: extremeDark),
        titleMedium: GoogleFonts.outfit(textStyle: baseTheme.textTheme.titleMedium, fontWeight: FontWeight.bold, color: extremeDark),
        bodyLarge: GoogleFonts.inter(textStyle: baseTheme.textTheme.bodyLarge, fontWeight: FontWeight.w700, color: extremeDark),
        bodyMedium: GoogleFonts.inter(textStyle: baseTheme.textTheme.bodyMedium, fontWeight: FontWeight.w700, color: Color(0xFF4A4A6A)),
        bodySmall: GoogleFonts.inter(textStyle: baseTheme.textTheme.bodySmall, fontWeight: FontWeight.w700, color: Color(0xFF4A4A6A)),
        labelLarge: GoogleFonts.inter(textStyle: baseTheme.textTheme.labelLarge, fontWeight: FontWeight.bold, color: extremeDark),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: extremeDark),
      ),
    );
  }
}
