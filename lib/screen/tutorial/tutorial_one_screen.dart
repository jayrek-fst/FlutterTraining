import 'package:flutter/material.dart';
import 'package:fumiya_flutter/util/app_color_util.dart';
import 'package:fumiya_flutter/util/route_util.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/asset_path_util.dart';
import '../../util/string_constants.dart';
import '../../widget/common_widget.dart';
import '../../widget/elevated_button_widget.dart';

class TutorialOneScreen extends StatelessWidget {
  const TutorialOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: AppColorUtil.appBlueColor,
                  child: Column(children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        color: Colors.white,
                        child: Image.asset(AssetPathUtil.appImagePath)),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(children: [
                            Text(appLocalizations.raw_tutorial_welcome_message,
                                style: Theme.of(context).textTheme.bodyText2),
                            _subscriptionBenefits(context, appLocalizations),
                            Text(
                                appLocalizations
                                    .raw_common_subscribe_payment_note,
                                style: Theme.of(context).textTheme.bodyText2),
                            ElevatedButtonWidget(
                                fontFamily: StringConstants.fontFutura,
                                label: appLocalizations.raw_common_next
                                    .toUpperCase(),
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(RouteUtil.tutorialTwo))
                          ])),
                    )
                  ]))),
        ));
  }

  Widget _subscriptionBenefits(
      BuildContext context, AppLocalizations appLocalizations) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        color: AppColorUtil.appBlueAccentColor,
        child: Column(children: [
          subscriptionBenefitsItem(
              context, appLocalizations.raw_common_subscribe_benefits_one),
          subscriptionBenefitsItem(
              context, appLocalizations.raw_common_subscribe_benefits_two),
          subscriptionBenefitsItem(
              context, appLocalizations.raw_common_subscribe_benefits_three)
        ]));
  }
}
