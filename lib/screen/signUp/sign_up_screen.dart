import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fumiya_flutter/bloc/toggle_bloc/toggle_bloc.dart';
import '../../util/app_color_util.dart';
import '../../util/image_path_util.dart';
import '../../util/route_util.dart';
import '../../util/string_constants.dart';
import '../../widget/toggle_password_widget.dart';
import '../../widget/elevated_button_widget.dart';
import '../../widget/text_form_field_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: AppColorUtil.appBlueColor,
        appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text(appLocalizations.raw_sign_in_header,
                style: const TextStyle(color: AppColorUtil.appBlueDarkColor))),
        body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                  height: MediaQuery.of(context).size.height,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(children: [
                    Text(appLocalizations.raw_sign_up_header_description),
                    Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: Image.asset(ImagePathUtil.stepOnePath)),
                    Text(appLocalizations.raw_sign_up_message),
                    const SizedBox(height: 20),
                    FormBuilder(
                        key: formKey,
                        child: Column(children: [
                          _emailFormBuilderTextField(context, appLocalizations),
                          const SizedBox(height: 10),
                          _passwordFormBuilderTextField(
                              context, appLocalizations),
                          const SizedBox(height: 10),
                          _confirmPasswordFormBuilderTextField(
                              context, appLocalizations),
                          ElevatedButtonWidget(
                              label: appLocalizations.raw_common_confirm,
                              onPressed: () => _validateForm(context))
                        ]))
                  ]))
            ]));
  }

  Widget _emailFormBuilderTextField(
      BuildContext context, AppLocalizations appLocalizations) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(appLocalizations.raw_common_email)),
      TextFormFieldWidget(
          name: StringConstants.email,
          textInputType: TextInputType.emailAddress,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
                errorText:
                    appLocalizations.raw_common_validation_invalid_empty_email),
            FormBuilderValidators.email(
                errorText:
                    appLocalizations.raw_common_validation_invalid_format_email)
          ]))
    ]);
  }

  Widget _passwordFormBuilderTextField(
      BuildContext context, AppLocalizations appLocalizations) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(appLocalizations.raw_common_password)),
      BlocBuilder<ToggleBloc, ToggleState>(builder: (context, state) {
        var isPasswordToggle = true;
        var isConfirmPasswordToggle = true;
        if (state is ToggleSignUpState) {
          isPasswordToggle = state.togglePassword;
          isConfirmPasswordToggle = state.toggleConfirmPassword;
        }
        return TextFormFieldWidget(
            name: StringConstants.password,
            isObscure: isPasswordToggle,
            textInputType: TextInputType.visiblePassword,
            hint: appLocalizations.raw_common_hint_password,
            suffixIcon: InkWell(
                onTap: () => context.read<ToggleBloc>().add(ToggleSignUpEvent(
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
          child: Text(appLocalizations.raw_common_confirm_password)),
      BlocBuilder<ToggleBloc, ToggleState>(builder: (context, state) {
        var isPasswordToggle = true;
        var isConfirmPasswordToggle = true;

        if (state is ToggleSignUpState) {
          isPasswordToggle = state.togglePassword;
          isConfirmPasswordToggle = state.toggleConfirmPassword;
        }
        return TextFormFieldWidget(
            name: StringConstants.confirmPassword,
            isObscure: isConfirmPasswordToggle,
            textInputType: TextInputType.visiblePassword,
            hint: appLocalizations.raw_common_hint_password,
            suffixIcon: InkWell(
                onTap: () => context.read<ToggleBloc>().add(ToggleSignUpEvent(
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
                  formKey.currentState!.fields[StringConstants.password]!.value
                      .toString(),
                  errorText:
                      appLocalizations.raw_common_invalid_confirm_password)
            ]));
      })
    ]);
  }

  void _validateForm(BuildContext context) {
    if (formKey.currentState!.saveAndValidate()) {
      debugPrint(formKey.currentState!.value[StringConstants.email]);
      debugPrint(formKey.currentState!.value[StringConstants.password]);
      debugPrint(formKey.currentState!.value[StringConstants.confirmPassword]);
      Navigator.of(context).pushNamed(RouteUtil.signUpVerification);
    }
  }
}