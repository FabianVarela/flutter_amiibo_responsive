import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmiiboTheme {
  static ThemeData setThemeData(BuildContext context, ColorScheme colorScheme) {
    final textTheme = Theme.of(context).textTheme;
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.nunitoTextTheme(
        textTheme.apply(
          bodyColor: colorScheme.onSurface,
          decorationColor: colorScheme.onSurface,
        ),
      ),
    );
  }
}
