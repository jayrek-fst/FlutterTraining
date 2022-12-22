import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/cubit/password_toggle_cubit/password_toggle_cubit.dart';
import 'text_form_field_widget.dart';
import 'toggle_password_widget.dart';

class TextFormFieldPasswordWidget extends StatelessWidget {
  const TextFormFieldPasswordWidget(
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
    var isPasswordToggle = true;

    return BlocProvider(
        create: (context) => PasswordToggleCubit(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(title)),
          BlocBuilder<PasswordToggleCubit, PasswordToggleState>(
              builder: (context, state) {
            if (state is PasswordToggleAction) isPasswordToggle = state.toggle;
            return TextFormFieldWidget(
                name: name,
                hint: hint,
                isObscure: isPasswordToggle,
                textInputType: TextInputType.visiblePassword,
                suffixIcon: InkWell(
                    onTap: () => context
                        .read<PasswordToggleCubit>()
                        .passwordToggle(!isPasswordToggle),
                    child: TogglePasswordSuffixIconWidget(
                        isToggle: isPasswordToggle)),
                validator: validator);
          })
        ]));
  }
}
