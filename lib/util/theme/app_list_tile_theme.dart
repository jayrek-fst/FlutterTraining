import 'package:flutter/material.dart';

class AppListTileTheme {
  static ListTileThemeData lightListTileTheme = const ListTileThemeData(
      textColor: Colors.white,
      iconColor: Colors.white,
      enableFeedback: false,
      contentPadding: EdgeInsets.symmetric(horizontal: 5));

  static ListTileThemeData darkListTileTheme = const ListTileThemeData();
}
