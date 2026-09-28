import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class AmiiboTheme {
  static ThemeData setThemeData(BuildContext context, ColorScheme colorScheme) {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.nunitoTextTheme(
        Theme.of(context).textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
          decorationColor: colorScheme.onSurface,
        ),
      ),
    );
  }
}
