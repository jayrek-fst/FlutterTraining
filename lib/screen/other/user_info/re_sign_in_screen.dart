import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fumiya_flutter/util/route_util.dart';
import 'package:fumiya_flutter/widget/common_widget.dart';

import '../../../business_logic/bloc/auth_bloc/auth_bloc.dart';
import '../../../business_logic/bloc/toggle_bloc/toggle_bloc.dart';
import '../../../util/string_constants.dart';
import '../../../util/style_util.dart';
import '../../../widget/elevated_button_widget.dart';
import '../../../widget/text_form_field_widget.dart';
import '../../../widget/toggle_password_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReSignInScreen extends StatelessWidget {
  ReSignInScreen({Key? key, required this.type}) : super(key: key);

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  final String type;

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
            title: Text(
                type == StringConstants.updateEmail
                    ? appLocalizations.raw_common_update_email
                    : appLocalizations.raw_common_update_password,
                style: appBarTitleTextStyle)),
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthUserAuthenticated) {
            Navigator.of(context).pushNamed(type == StringConstants.updateEmail
                ? RouteUtil.updateEmail
                : RouteUtil.updatePassword);
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
                    child: Stack(children: [
                      Column(children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 30),
                            child: Text(
                                type == StringConstants.updateEmail
                                    ? appLocalizations.raw_common_update_email
                                    : appLocalizations
                                        .raw_common_update_password,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))),
                        Text(appLocalizations
                            .raw_re_sign_in_update_password_description),
                        const SizedBox(height: 20),
                        FormBuilder(
                            key: formKey,
                            child: Column(children: [
                              _passwordFormBuilderTextField(
                                  context, appLocalizations),
                              const SizedBox(height: 10),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: TextButton(
                                      onPressed: () => Navigator.of(context)
                                          .pushNamed(RouteUtil.resetPassword,
                                              arguments: RouteUtil.userInfo),
                                      child: Text(
                                          appLocalizations
                                              .raw_common_forgot_password,
                                          style: underlineTextStyle))),
                              ElevatedButtonWidget(
                                  label: appLocalizations.raw_common_next,
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    if (formKey.currentState!
                                        .saveAndValidate()) {
                                      String password = formKey.currentState
                                          ?.value[StringConstants.password];
                                      context.read<AuthBloc>().add(
                                          AuthReSignIn(password: password));
                                    }
                                  })
                            ]))
                      ])
                    ]))),
            if (state is AuthLoading) progressDialog()
          ]);
        }));
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
                onTap: () => context.read<ToggleBloc>().add(ToggleSignedIn(
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
}
