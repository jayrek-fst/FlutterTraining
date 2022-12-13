import 'package:flutter/material.dart';

import '../app_color_util.dart';

class AppElevatedButtonTheme {
  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColorUtil.appBlueDarkColor,
              minimumSize: const Size(double.infinity, 50),
              side: const BorderSide(width: 1, color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))));

  static ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData();
}
