import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/toggle_bloc/toggle_bloc.dart';
import '../../util/app_color_util.dart';
import '../../util/route_util.dart';
import '../../util/string_constants.dart';
import '../../util/text_style_util.dart';
import '../../widget/toggle_password_widget.dart';
import '../../widget/elevated_button_widget.dart';
import '../../widget/text_form_field_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

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
                    Text(appLocalizations
                        .raw_common_billing_subscription_message),
                    ElevatedButtonWidget(
                        label: appLocalizations.raw_sign_up_header,
                        onPressed: () =>
                            Navigator.of(context).pushNamed(RouteUtil.signUp)),
                    Text(
                        '———  ${appLocalizations.raw_sign_in_click_here}  ———'),
                    const SizedBox(height: 20),
                    FormBuilder(
                        key: formKey,
                        child: Column(children: [
                          _emailFormBuilderTextField(context, appLocalizations),
                          const SizedBox(height: 10),
                          _passwordFormBuilderTextField(
                              context, appLocalizations),
                          const SizedBox(height: 10),
                          ElevatedButtonWidget(
                              label: appLocalizations.raw_common_sign_in,
                              onPressed: () => _validateForm(context))
                        ])),
                    TextButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(RouteUtil.resetPassword),
                        child: Text(
                            appLocalizations.raw_sign_in_forgot_password,
                            style: underlineTextStyle))
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
    var isPasswordToggle = true;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(appLocalizations.raw_common_password)),
      BlocBuilder<ToggleBloc, ToggleState>(builder: (context, state) {
        if (state is ToggleSignInState) isPasswordToggle = state.togglePassword;
        return TextFormFieldWidget(
            name: StringConstants.password,
            isObscure: isPasswordToggle,
            textInputType: TextInputType.visiblePassword,
            suffixIcon: InkWell(
                onTap: () => context.read<ToggleBloc>().add(ToggleSignInEvent(
                    toggleState:
                        ToggleSignInState(togglePassword: !isPasswordToggle))),
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

  void _validateForm(BuildContext context) {
    if (formKey.currentState!.saveAndValidate()) {
      debugPrint(formKey.currentState!.value[StringConstants.email]);
      debugPrint(formKey.currentState!.value[StringConstants.password]);
      debugPrint(formKey.currentState!.value[StringConstants.confirmPassword]);
      FocusScope.of(context).unfocus();
      Navigator.of(context).pushNamed(RouteUtil.dashboard);
      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil(RouteUtil.dashboard, (route) => false);
    }
  }
}
