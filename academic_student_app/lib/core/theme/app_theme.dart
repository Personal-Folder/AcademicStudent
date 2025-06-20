import 'package:academic_student/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ColorScheme _lightColorScheme =
    ColorScheme.fromSeed(seedColor: primaryColor, brightness: Brightness.light);
ColorScheme _darkColorScheme =
    ColorScheme.fromSeed(seedColor: primaryColor, brightness: Brightness.dark);

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      // useMaterial3: false,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      textTheme: GoogleFonts.montserratTextTheme());
  static ThemeData darkTheme = ThemeData(
      // useMaterial3: false,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      textTheme: GoogleFonts.montserratTextTheme());
}
