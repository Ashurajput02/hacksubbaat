import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

var box = Hive.box('appBox');
var theme = box.get('Dark Theme');

Color stringToColor(String color) {
  return Color(int.parse(color.substring(0, 6), radix: 16) + 0xFF000000);
}

ThemeData darkmode = ThemeData(
    fontFamily: GoogleFonts.getFont('${box.get('App Font')}').fontFamily,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: stringToColor(theme['surface']),
      surfaceContainer: stringToColor(theme['surfaceContainer']),
      primary: stringToColor(theme['primary']),
      onSurface: stringToColor(theme['onSurface']),
      onSurfaceVariant: stringToColor(theme['onSurfaceVariant']),
      onPrimary: stringToColor(theme['onPrimary']),
    ));
