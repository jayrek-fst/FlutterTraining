import 'package:flutter/material.dart';

import '../app_color_util.dart';
import '../string_constants.dart';
import 'app_app_bar_theme.dart';
import 'app_checkbox_theme.dart';
import 'app_elevated_button_theme.dart';
import 'app_list_tile_theme.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: StringConstants.fontNotoSans,
      primaryColor: AppColorUtil.appBlueColor,
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: AppColorUtil.appBlueColor,
      errorColor: AppColorUtil.appOrangeColor,
      textTheme: AppTextTheme.lightTextTheme,
      appBarTheme: AppAppBarTheme.lightAppBarTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
      checkboxTheme: AppCheckboxTheme.lightCheckBoxTheme,
      listTileTheme: AppListTileTheme.lightListTileTheme);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
  );
}
