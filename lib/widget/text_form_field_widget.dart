import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../util/style_util.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {Key? key,
      required this.name,
      required this.textInputType,
      this.validator,
      this.hint = '',
      this.suffixIcon,
      this.isObscure = false,
      this.initialValue = ''})
      : super(key: key);
  final String name;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool isObscure;
  final String hint;
  final String initialValue;

  // final Function(String?)? onChange;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) => FormBuilderTextField(
            name: name,
            validator: validator,
            keyboardType: textInputType,
            obscureText: isObscure,
            initialValue: initialValue,
            style: inputTextFormFieldTextStyle,
            onChanged: (_) => setState(() {}),
            decoration: textFormFieldDecoration(hint, suffixIcon)));
  }
}
