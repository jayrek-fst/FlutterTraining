import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../business_logic/bloc/auth_bloc/auth_bloc.dart';
import '../../../util/string_constants.dart';
import '../../../util/style_util.dart';
import '../../../widget/common_widget.dart';
import '../../../widget/elevated_button_widget.dart';
import '../../../widget/text_form_field_email_widget.dart';

class UpdateEmailScreen extends StatelessWidget {
  UpdateEmailScreen({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
            title: Text(appLocalizations.raw_common_update_email,
                style: appBarTitleTextStyle)),
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthEmailUpdated) {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text(appLocalizations.raw_common_update_email_success)));
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
                                      appLocalizations.raw_common_update_email,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(appLocalizations
                                        .raw_update_email_current_email(
                                            "test@mailinator.com", '\n')),
                                    const SizedBox(height: 20),
                                    TextFormFieldEmailWidget(
                                        name: StringConstants.newEmail,
                                        title: appLocalizations
                                            .raw_common_new_email,
                                        hint: appLocalizations
                                            .raw_common_new_email,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              errorText: appLocalizations
                                                  .raw_common_validation_invalid_empty_email),
                                          FormBuilderValidators.email(
                                              errorText: appLocalizations
                                                  .raw_common_validation_invalid_format_email)
                                        ])),
                                    const SizedBox(height: 10),
                                    TextFormFieldEmailWidget(
                                        name: StringConstants
                                            .newEmailConfirmation,
                                        title: appLocalizations
                                            .raw_common_new_email_confirmation,
                                        hint: appLocalizations
                                            .raw_common_new_email_confirmation,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              errorText: appLocalizations
                                                  .raw_common_validation_invalid_empty_email),
                                          FormBuilderValidators.email(
                                              errorText: appLocalizations
                                                  .raw_common_validation_invalid_format_email),
                                          (val) {
                                            if (val !=
                                                _formKey
                                                    .currentState!
                                                    .fields[StringConstants
                                                        .newEmail]!
                                                    .value
                                                    .toString()) {
                                              return appLocalizations
                                                  .raw_common_invalid_confirm_email;
                                            }
                                            return null;
                                          }
                                        ])),
                                    const SizedBox(height: 10),
                                    ElevatedButtonWidget(
                                        label:
                                            appLocalizations.raw_common_update,
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          if (_formKey.currentState!
                                              .saveAndValidate()) {
                                            context.read<AuthBloc>().add(
                                                AuthUpdateEmail(
                                                    email: _formKey
                                                        .currentState!
                                                        .value[StringConstants
                                                            .newEmail]
                                                        .toString()));
                                          }
                                        })
                                  ])
                            ]))))),
            if (state is AuthLoading) progressDialog()
          ]);
        }));
  }
}
