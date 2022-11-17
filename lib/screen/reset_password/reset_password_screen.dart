import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fumiya_flutter/bloc/auth_bloc/auth_bloc.dart';
import 'package:fumiya_flutter/widget/common_widget.dart';
import '../../util/app_color_util.dart';
import '../../util/route_util.dart';
import '../../util/string_constants.dart';
import '../../widget/elevated_button_widget.dart';
import '../../widget/text_form_field_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: AppColorUtil.appBlueColor,
        appBar: AppBar(
            leading: const BackButton(color: AppColorUtil.appBlueDarkColor),
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text(appLocalizations.raw_common_reset_password,
                style: const TextStyle(color: AppColorUtil.appBlueDarkColor))),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthPasswordEmailVerificationSent) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteUtil.resetPasswordVerification, (route) => false);
            }
            if (state is AuthExceptionOccurred) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          }, builder: (context, state) {
            return Stack(children: [
              Column(children: [
                Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 30),
                    child: Text(appLocalizations.raw_common_reset_password)),
                Text(appLocalizations.raw_reset_password_description),
                const SizedBox(height: 20),
                FormBuilder(
                    key: formKey,
                    child: Column(children: [
                      _emailFormBuilderTextField(context, appLocalizations),
                      const SizedBox(height: 10),
                      Text(appLocalizations.raw_common_reset_password_note),
                      const SizedBox(height: 10),
                      ElevatedButtonWidget(
                          label: appLocalizations.raw_common_next,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.saveAndValidate()) {
                              context.read<AuthBloc>().add(
                                  AuthSendResetPassword(
                                      email: formKey.currentState
                                          ?.value[StringConstants.email]));
                            }
                          })
                    ]))
              ]),
              if (state is AuthLoading) progressDialog()
            ]);
          }),
        )));
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
}
