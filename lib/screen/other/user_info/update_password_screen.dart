import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../business_logic/bloc/auth_bloc/auth_bloc.dart';
import '../../../business_logic/bloc/toggle_bloc/toggle_bloc.dart';
import '../../../util/string_constants.dart';
import '../../../util/style_util.dart';
import '../../../widget/common_widget.dart';
import '../../../widget/elevated_button_widget.dart';
import '../../../widget/text_form_field_widget.dart';
import '../../../widget/toggle_password_widget.dart';

class UpdatePasswordScreen extends StatelessWidget {
  UpdatePasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
            title: Text(appLocalizations.raw_common_update_password,
                style: appBarTitleTextStyle)),
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AutPasswordUpdated) {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text(appLocalizations.raw_common_update_password_success)));
          }
          if (state is AuthExceptionOccurred) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }, builder: (context, state) {
          return Stack(children: [
            SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FormBuilder(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 30),
                                  child: Text(
                                      appLocalizations
                                          .raw_common_update_password,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _passwordFormBuilderTextField(
                                        context, appLocalizations),
                                    const SizedBox(height: 10),
                                    _confirmPasswordFormBuilderTextField(
                                        context, appLocalizations),
                                    const SizedBox(height: 10),
                                    ElevatedButtonWidget(
                                        label:
                                            appLocalizations.raw_common_update,
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState!
                                              .saveAndValidate()) {
                                            context.read<AuthBloc>().add(
                                                AuthUpdatePassword(
                                                    password: _formKey
                                                            .currentState!
                                                            .value[
                                                        StringConstants
                                                            .newPassword]));
                                          }
                                        })
                                  ])
                            ]))))),
            if (state is AuthLoading) progressDialog()
          ]);
        }));
  }

  Widget _passwordFormBuilderTextField(
      BuildContext context, AppLocalizations appLocalizations) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(appLocalizations.raw_common_new_password)),
      BlocBuilder<ToggleBloc, ToggleState>(builder: (context, state) {
        var isPasswordToggle = true;
        var isConfirmPasswordToggle = true;
        if (state is ToggleSignUpState) {
          isPasswordToggle = state.togglePassword;
          isConfirmPasswordToggle = state.toggleConfirmPassword;
        }
        return TextFormFieldWidget(
            name: StringConstants.newPassword,
            isObscure: isPasswordToggle,
            textInputType: TextInputType.visiblePassword,
            hint: appLocalizations.raw_common_new_password,
            suffixIcon: InkWell(
                onTap: () => context.read<ToggleBloc>().add(ToggleSignedUp(
                    toggleState: ToggleSignUpState(
                        togglePassword: !isPasswordToggle,
                        toggleConfirmPassword: isConfirmPasswordToggle))),
                child:
                    TogglePasswordSuffixIconWidget(isToggle: isPasswordToggle)),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: appLocalizations
                      .raw_common_validation_invalid_empty_password),
              FormBuilderValidators.match(StringConstants.passwordPatternRegEx,
                  errorText: appLocalizations
                      .raw_common_validation_invalid_format_password)
            ]));
      })
    ]);
  }

  Widget _confirmPasswordFormBuilderTextField(
      BuildContext context, AppLocalizations appLocalizations) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(appLocalizations.raw_common_new_password_confirmation)),
      BlocBuilder<ToggleBloc, ToggleState>(builder: (context, state) {
        var isPasswordToggle = true;
        var isConfirmPasswordToggle = true;

        if (state is ToggleSignUpState) {
          isPasswordToggle = state.togglePassword;
          isConfirmPasswordToggle = state.toggleConfirmPassword;
        }
        return TextFormFieldWidget(
            name: StringConstants.newPasswordConfirmation,
            isObscure: isConfirmPasswordToggle,
            textInputType: TextInputType.visiblePassword,
            hint: appLocalizations.raw_common_new_password_confirmation,
            suffixIcon: InkWell(
                onTap: () => context.read<ToggleBloc>().add(ToggleSignedUp(
                    toggleState: ToggleSignUpState(
                        togglePassword: isPasswordToggle,
                        toggleConfirmPassword: !isConfirmPasswordToggle))),
                child: TogglePasswordSuffixIconWidget(
                    isToggle: isConfirmPasswordToggle)),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText:
                      appLocalizations.raw_common_input_confirm_password),
              FormBuilderValidators.match(StringConstants.passwordPatternRegEx,
                  errorText: appLocalizations
                      .raw_common_validation_invalid_format_password),
              FormBuilderValidators.equal(
                  _formKey
                      .currentState!.fields[StringConstants.newPassword]!.value
                      .toString(),
                  errorText:
                      appLocalizations.raw_common_invalid_confirm_password)
            ]));
      })
    ]);
  }
}
