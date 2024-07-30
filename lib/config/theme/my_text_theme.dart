import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guardowl/config/config.dart';

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);

  TextTheme textTheme = displayTextTheme.copyWith(
    //size: 24, Regular, color: morado
    headlineSmall:
        bodyTextTheme.headlineSmall?.copyWith(color: colorScheme.primary),
    //size: 22, medium
    titleLarge:
        displayTextTheme.titleLarge?.copyWith(color: colorScheme.primary),
    //size: 16, regular
    bodyLarge: bodyTextTheme.bodyLarge,
    //size: 14, regular para textos
    bodyMedium: bodyTextTheme.bodyMedium,
    //size: 12, regular
    bodySmall: bodyTextTheme.bodySmall,
    //size: 14, medium, seminegrita
    labelLarge: bodyTextTheme.labelLarge,
    //size: 12 y en copywith 10, medium
    labelMedium: bodyTextTheme.labelMedium,
    //size: 11, medium
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}
