import 'package:flutter/material.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = const TextTheme(
      headline6: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
      bodyText2: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white));

  static TextTheme darkTextTheme = TextTheme();
}
