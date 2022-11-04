import 'package:flutter/material.dart';

import 'app_color_util.dart';
import 'string_constants.dart';

TextStyle underlineTextStyle =
    const TextStyle(color: Colors.white, decoration: TextDecoration.underline);

TextStyle hintTextStyle = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColorUtil.appBlueAccentColor);

TextStyle inputTextFormFieldTextStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600);

TextStyle bottomNavBarItemTextStyle = const TextStyle(
    fontFamily: StringConstants.fontFutura,
    fontSize: 15,
    fontWeight: FontWeight.w500);

InputDecoration textFormFieldDecoration(String hint, Widget? suffixIcon) {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      hintStyle: hintTextStyle,
      suffixIcon: suffixIcon,
      errorStyle: const TextStyle(color: AppColorUtil.appOrangeColor),
      contentPadding: const EdgeInsets.all(12),
      border: InputBorder.none,
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(1))),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(1))),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColorUtil.appOrangeColor, width: 2)),
      errorBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColorUtil.appOrangeColor, width: 2)));
}
