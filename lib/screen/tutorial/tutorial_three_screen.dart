import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../util/app_color_util.dart';
import '../../util/image_path_util.dart';
import '../../util/route_util.dart';
import '../../util/string_constants.dart';
import '../../widget/elevated_button_widget.dart';

class TutorialThreeScreen extends StatelessWidget {
  const TutorialThreeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(appLocalizations.raw_member_only_content),
            centerTitle: true),
        body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(appLocalizations.raw_tutorial_three_message,
                      style: const TextStyle(
                          color: AppColorUtil.appBlueDarkColor))),
              Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  height: MediaQuery.of(context).size.height,
                  child: Column(children: [
                    SizedBox(
                        height: 500,
                        child: Image.asset(ImagePathUtil.tutorialImage3Path)),
                    ElevatedButtonWidget(
                        fontFamily: StringConstants.fontFutura,
                        label: appLocalizations.raw_common_enter.toUpperCase(),
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                RouteUtil.signIn, (route) => false))
                  ]))
            ]));
  }
}