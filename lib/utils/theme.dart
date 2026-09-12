import 'package:material_ui/material_ui.dart';

class AmiiboTheme {
  static ThemeData setThemeData(BuildContext context, ColorScheme colorScheme) {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: colorScheme,
      // TODO(FV): Uncomment when package is ready
      /*
      textTheme: GoogleFonts.nunitoTextTheme(
        Theme.of(context).textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
          decorationColor: colorScheme.onSurface,
        ),
      ),
      */
    );
  }
}
