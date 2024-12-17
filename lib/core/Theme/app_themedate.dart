import 'color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ThemeColor.mainBlue,
    colorScheme: ColorScheme.light(
      primary: ThemeColor.mainBlue,
      secondary: Colors.grey,
    ),
    fontFamily: "JannaLT-Regular",
  );
}
