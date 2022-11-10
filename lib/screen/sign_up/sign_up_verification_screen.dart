import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../util/app_color_util.dart';
import '../../util/image_path_util.dart';
import '../../util/route_util.dart';
import '../../util/text_style_util.dart';

class SignUpVerificationScreen extends StatelessWidget {
  const SignUpVerificationScreen({Key? key}) : super(key: key);

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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Column(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(appLocalizations.raw_sign_up_verification_header),
                        Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 30),
                            child: Image.asset(ImagePathUtil.stepTwoPath))
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appLocalizations
                            .raw_sign_up_verification_description),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      RouteUtil.signIn, (route) => false),
                              child: Text(
                                  appLocalizations
                                      .raw_sign_up_verification_completed,
                                  style: underlineTextStyle.copyWith(
                                      color: AppColorUtil.appOrangeColor)),
                            )),
                        Text(appLocalizations.raw_sign_up_verification_message),
                        Text(
                            '・${appLocalizations.raw_sign_up_verification_message_bullet_1}'),
                        Text(
                            '・${appLocalizations.raw_sign_up_verification_message_bullet_2}'),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                  appLocalizations
                                      .raw_sign_up_verification_resend,
                                  style: underlineTextStyle.copyWith(
                                      color: AppColorUtil.appOrangeColor)),
                            )),
                        Text(appLocalizations.raw_sign_up_verification_inquiry),
                        Text(
                            '・${appLocalizations.raw_sign_up_verification_inquiry_bullet_1}'),
                        Text(
                            '・${appLocalizations.raw_sign_up_verification_inquiry_bullet_2}'),
                        Text(
                            '・${appLocalizations.raw_sign_up_verification_inquiry_bullet_3}'),
                        Text(
                            '・${appLocalizations.raw_sign_up_verification_inquiry_bullet_4}')
                      ]),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(appLocalizations
                                    .raw_sign_up_verification_inquiry_2),
                                Row(children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                          appLocalizations
                                              .raw_sign_up_verification_contact_inquiry,
                                          style: underlineTextStyle.copyWith(
                                              color: AppColorUtil
                                                  .appOrangeColor))),
                                  Text(appLocalizations
                                      .raw_sign_up_verification_contact_us)
                                ])
                              ])))
                ])
              ]),
        ));
  }
}
