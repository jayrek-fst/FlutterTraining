import 'package:flutter/material.dart';

import 'text_form_field_widget.dart';

class TextFormFieldEmailWidget extends StatelessWidget {
  const TextFormFieldEmailWidget(
      {Key? key,
      required this.name,
      required this.title,
      this.hint = '',
      this.validator})
      : super(key: key);

  final String name;
  final String title;
  final String hint;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(title)),
      TextFormFieldWidget(
          name: name,
          hint: hint,
          textInputType: TextInputType.emailAddress,
          validator: validator)
    ]);
  }
}
