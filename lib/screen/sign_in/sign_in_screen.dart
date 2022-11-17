import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/toggle_bloc/toggle_bloc.dart';
import '../../business_logic/cubit/password_toggle_cubit.dart';
import '../../util/app_color_util.dart';
import '../../util/route_util.dart';
import '../../util/string_constants.dart';
import '../../util/style_util.dart';
import '../../widget/alert_dialog_widget.dart';
import '../../widget/common_widget.dart';
import '../../widget/toggle_password_widget.dart';
import '../../widget/elevated_button_widget.dart';
import '../../widget/text_form_field_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

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
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthUserAuthenticated) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(RouteUtil.dashboard, (route) => false);
          }
          if (state is UserInfoNotExisted) {
            Navigator.of(context).pushNamed(RouteUtil.signUpDetails);
          }
          if (state is AuthExceptionOccurred) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AuthUserEmailUnVerified) {
            _showSignInDialog(
                context,
                appLocalizations.raw_sign_in_dialog_title_login_error,
                appLocalizations.raw_sign_in_dialog_message_email_unverified,
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(appLocalizations.raw_common_close)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context
                            .read<AuthBloc>()
                            .add(AuthSendEmailVerification());
                      },
                      child:
                          Text(appLocalizations.raw_sign_in_dialog_btn_resend))
                ]);
          }
          if (state is AuthEmailVerificationSent) {
            _showSignInDialog(
                context,
                appLocalizations.raw_sign_in_dialog_title_resend_result,
                appLocalizations.raw_verification_authentication_sent,
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(appLocalizations.raw_common_close))
                ]);
          }
        }, builder: (context, state) {
          return Stack(children: [
            SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(appLocalizations
                        .raw_common_billing_subscription_message)),
                ElevatedButtonWidget(
                    label: appLocalizations.raw_sign_up_header,
                    onPressed: () =>
                        Navigator.of(context).pushNamed(RouteUtil.signUp)),
                Text('———  ${appLocalizations.raw_sign_in_click_here}  ———'),
                const SizedBox(height: 20),
                FormBuilder(
                    key: _formKey,
                    child: _signInForm(context, appLocalizations, state)),
                TextButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(RouteUtil.resetPassword),
                    child: Text(appLocalizations.raw_sign_in_forgot_password,
                        style: underlineTextStyle))
              ]),
            )),
            if (state is AuthLoading) progressDialog()
          ]);
        }));
  }

  Widget _signInForm(BuildContext context, AppLocalizations appLocalizations,
      AuthState state) {
    return Column(children: [
      _emailFormBuilderTextField(context, appLocalizations),
      const SizedBox(height: 10),
      _passwordFormBuilderTextField(context, appLocalizations),
      const SizedBox(height: 10),
      ElevatedButtonWidget(
          label: appLocalizations.raw_common_sign_in,
          onPressed: () {
            FocusScope.of(context).unfocus();
            if (_formKey.currentState!.saveAndValidate()) {
              context.read<AuthBloc>().add(AuthSignIn(formKey: _formKey));
            }
          })
    ]);
  }

  Future _showSignInDialog(BuildContext context, String title, String message,
      {List<Widget>? actions}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialogWidget(
            title: title, message: message, widgetActions: actions));
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

  Widget _passwordCubitFormBuilderTextField(
      BuildContext context, AppLocalizations appLocalizations) {
    var isPasswordToggle = true;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(appLocalizations.raw_common_password)),
      BlocBuilder<PasswordToggleCubit, PasswordToggleState>(
          builder: (context, state) {
        if (state is PasswordToggleAction) isPasswordToggle = state.toggle;
        return TextFormFieldWidget(
            name: StringConstants.password,
            isObscure: isPasswordToggle,
            textInputType: TextInputType.visiblePassword,
            suffixIcon: InkWell(
                onTap: () => context
                    .read<PasswordToggleCubit>()
                    .passwordToggle(!isPasswordToggle),
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
