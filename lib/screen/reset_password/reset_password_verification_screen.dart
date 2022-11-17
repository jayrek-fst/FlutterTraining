import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../util/app_color_util.dart';
import '../../util/route_util.dart';
import '../../util/style_util.dart';

class ResetPasswordVerificationScreen extends StatelessWidget {
  const ResetPasswordVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: AppColorUtil.appBlueColor,
        appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text(appLocalizations.raw_common_reset_password,
                style: const TextStyle(color: AppColorUtil.appBlueDarkColor))),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: Text(
                    appLocalizations.raw_reset_password_verification_header)),
            Text(appLocalizations.raw_reset_password_verification_description),
            const SizedBox(height: 20),
            Text(appLocalizations.raw_reset_password_verification_message),
            const SizedBox(height: 20),
            Text(appLocalizations.raw_reset_password_verification_note_1),
            const SizedBox(height: 20),
            Text(appLocalizations.raw_reset_password_verification_note_2),
            const SizedBox(height: 30),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteUtil.signIn, (route) => false),
                child: Text(appLocalizations.raw_common_back_to_login,
                    style: underlineTextStyle)),
            const SizedBox(height: 20)
          ]),
        )));
  }
}
