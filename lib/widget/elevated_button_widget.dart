import 'package:flutter/material.dart';

import '../util/string_constants.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.fontFamily = StringConstants.fontNotoSans})
      : super(key: key);
  final String label;
  final Function() onPressed;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: ElevatedButton(
            onPressed: onPressed,
            child: Text(label,
                style: TextStyle(fontFamily: fontFamily, fontSize: 22))));
  }
}
