import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors based on Tailwind config
  static const Color primary = Color(0xFF3D47DE);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF5863F8);
  static const Color onPrimaryContainer = Color(0xFFFFFDFF);

  static const Color secondary = Color(0xFF5156A7);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFA1A7FE);
  static const Color onSecondaryContainer = Color(0xFF333888);
  
  static const Color tertiary = Color(0xFF006952);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF008568);
  static const Color onTertiaryContainer = Color(0xFFF9FFFA);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color surface = Color(0xFFFCF9F8);
  static const Color onSurface = Color(0xFF1C1B1B);
  static const Color surfaceVariant = Color(0xFFE5E2E1);
  static const Color onSurfaceVariant = Color(0xFF454555);
  
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF6F3F2);
  static const Color surfaceContainer = Color(0xFFF0EDEC);
  static const Color surfaceContainerHigh = Color(0xFFEBE7E7);
  static const Color surfaceContainerHighest = Color(0xFFE5E2E1);

  static const Color outline = Color(0xFF767687);
  static const Color outlineVariant = Color(0xFFC6C5D8);

  // Custom specific colors from design
  static const Color primaryFixed = Color(0xFFE0E0FF);
  static const Color primaryFixedDim = Color(0xFFBEC2FF);
  static const Color onPrimaryFixed = Color(0xFF00026C);
  static const Color onPrimaryFixedVariant = Color(0xFF222BC9);
  
  static const Color secondaryFixed = Color(0xFFE0E0FF);
  static const Color onSecondaryFixed = Color(0xFF070963);
  static const Color onSecondaryFixedVariant = Color(0xFF393E8E);
  
  static const Color tertiaryFixed = Color(0xFF64FBCE);
  
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surface,
        onSurface: onSurface,
        surfaceContainerHighest: surfaceVariant,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
      ),
      scaffoldBackgroundColor: surface,
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.64, color: onSurface), // h1
        displayMedium: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -0.24, color: onSurface), // h2
        displaySmall: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: onSurface), // h3
        bodyLarge: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400, height: 1.6, color: onSurface), // body-lg
        bodyMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, height: 1.6, color: onSurface), // body-md
        bodySmall: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, height: 1.5, color: onSurfaceVariant), // body-sm
        labelLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.16, color: onPrimary), // button
        labelSmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.6, color: onSurfaceVariant), // label-caps
      ),
    );
  }
}
