import 'package:flutter/material.dart';
import 'package:fumiya_flutter/util/app_color_util.dart';
import 'package:fumiya_flutter/util/route_util.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/image_path_util.dart';
import '../../util/string_constants.dart';
import '../../widget/common_widget.dart';
import '../../widget/elevated_button_widget.dart';

class TutorialOneScreen extends StatelessWidget {
  const TutorialOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Image.asset(ImagePathUtil.appImagePath)),
          Container(
              color: AppColorUtil.appBlueColor,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                Text(appLocalizations.raw_tutorial_welcome_message,
                    style: Theme.of(context).textTheme.bodyText2),
                _subscriptionBenefits(context, appLocalizations),
                Text(appLocalizations.raw_common_subscribe_payment_note,
                    style: Theme.of(context).textTheme.bodyText2),
                ElevatedButtonWidget(
                    fontFamily: StringConstants.fontFutura,
                    label: appLocalizations.raw_common_next.toUpperCase(),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(RouteUtil.tutorialTwo))
              ]))
        ]));
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
