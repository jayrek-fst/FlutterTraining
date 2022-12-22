import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../business_logic/bloc/auth_bloc/auth_bloc.dart';
import '../../../util/route_util.dart';
import '../../../util/string_constants.dart';
import '../../../util/style_util.dart';
import '../../../widget/common_widget.dart';
import '../../../widget/elevated_button_widget.dart';
import '../../../widget/text_form_field_password_widget.dart';

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
                              TextFormFieldPasswordWidget(
                                  name: StringConstants.password,
                                  title: appLocalizations.raw_common_password,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: appLocalizations
                                            .raw_common_validation_invalid_empty_password),
                                    FormBuilderValidators.match(
                                        StringConstants.passwordPatternRegEx,
                                        errorText: appLocalizations
                                            .raw_common_validation_invalid_format_password)
                                  ])),
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
                                          ReSignIn(password: password));
                                    }
                                  })
                            ]))
                      ])
                    ]))),
            if (state is AuthLoading) progressDialog()
          ]);
        }));
  }
}
