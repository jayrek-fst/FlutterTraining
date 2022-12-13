import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fumiya_flutter/business_logic/bloc/user_bloc/user_bloc.dart';
import '../../../util/string_constants.dart';
import '../../../util/style_util.dart';
import '../../../widget/common_widget.dart';
import '../../../widget/elevated_button_widget.dart';
import '../../../widget/text_form_field_password_widget.dart';

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
        body: BlocConsumer<UserBloc, UserState>(listener: (context, state) {
          if (state is UserActionSuccess) {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text(appLocalizations.raw_common_update_password_success)));
          }
          if (state is ExceptionOccurred) {
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
                                    TextFormFieldPasswordWidget(
                                        name: StringConstants.newPassword,
                                        title: appLocalizations
                                            .raw_common_new_password,
                                        hint: appLocalizations
                                            .raw_common_new_password,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              errorText: appLocalizations
                                                  .raw_common_validation_invalid_empty_password),
                                          FormBuilderValidators.match(
                                              StringConstants
                                                  .passwordPatternRegEx,
                                              errorText: appLocalizations
                                                  .raw_common_validation_invalid_format_password)
                                        ])),
                                    const SizedBox(height: 10),
                                    TextFormFieldPasswordWidget(
                                        name: StringConstants
                                            .newPasswordConfirmation,
                                        title: appLocalizations
                                            .raw_common_new_password_confirmation,
                                        hint: appLocalizations
                                            .raw_common_new_password_confirmation,
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              errorText: appLocalizations
                                                  .raw_common_input_confirm_password),
                                          FormBuilderValidators.match(
                                              StringConstants
                                                  .passwordPatternRegEx,
                                              errorText: appLocalizations
                                                  .raw_common_validation_invalid_format_password),
                                          (val) {
                                            if (val !=
                                                _formKey
                                                    .currentState!
                                                    .fields[StringConstants
                                                        .newPassword]!
                                                    .value
                                                    .toString()) {
                                              return appLocalizations
                                                  .raw_common_invalid_confirm_password;
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
                                            context.read<UserBloc>().add(
                                                UpdatePassword(
                                                    password: _formKey
                                                            .currentState!
                                                            .value[
                                                        StringConstants
                                                            .newPassword]));
                                          }
                                        })
                                  ])
                            ]))))),
            if (state is Loading) progressDialog()
          ]);
        }));
  }
}
