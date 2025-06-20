import 'package:academic_student/core/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlueTheme extends ThemeManager {
  Color primaryColor = const Color(0xFF2F81BB);
  Color secondaryColor = const Color(0xFF828182);
  @override
  ThemeData getTheme() => ThemeData(
      textTheme: GoogleFonts.montserratTextTheme(),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[200],
          hintStyle: TextStyle(color: secondaryColor),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor))),
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: secondaryColor,
          secondary: secondaryColor,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.grey[200]!,
          onSurface: Colors.black));
}
