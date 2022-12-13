import 'package:flutter/material.dart';

import '../app_color_util.dart';

class AppCheckboxTheme {
  static CheckboxThemeData lightCheckBoxTheme = CheckboxThemeData(
      checkColor: MaterialStateProperty.all(AppColorUtil.appBlueColor),
      fillColor: MaterialStateProperty.all(Colors.white));

  static CheckboxThemeData darkCheckBoxTheme = CheckboxThemeData();
}
