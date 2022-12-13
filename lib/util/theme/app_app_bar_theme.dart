import 'package:flutter/material.dart';

import '../app_color_util.dart';

class AppAppBarTheme {
  static AppBarTheme lightAppBarTheme = const AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      backgroundColor: AppColorUtil.appBlueDarkColor);

  static AppBarTheme darkAppBarTheme = AppBarTheme();
}
