import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../util/text_style_util.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {Key? key,
      required this.name,
      required this.textInputType,
      required this.validator,
      this.hint = '',
      this.suffixIcon,
      this.isObscure = false})
      : super(key: key);
  final String name;
  final TextInputType textInputType;
  final String? Function(String?) validator;
  final Widget? suffixIcon;
  final bool isObscure;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) => FormBuilderTextField(
            name: name,
            validator: validator,
            keyboardType: textInputType,
            obscureText: isObscure,
            style: inputTextFormFieldTextStyle,
            onChanged: (_) => setState(() {}),
            decoration: textFormFieldDecoration(hint, suffixIcon)));
  }
}
