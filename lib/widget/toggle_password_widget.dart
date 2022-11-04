import 'package:flutter/material.dart';

import '../util/app_color_util.dart';

class TogglePasswordSuffixIconWidget extends StatelessWidget {
  const TogglePasswordSuffixIconWidget({Key? key, required this.isToggle})
      : super(key: key);
  final bool isToggle;

  @override
  Widget build(BuildContext context) {
    return isToggle
        ? const Icon(Icons.visibility_off_rounded, color: Colors.grey)
        : const Icon(Icons.visibility_rounded,
            color: AppColorUtil.appBlueColor);
  }
}
