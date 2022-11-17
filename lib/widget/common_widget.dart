import 'package:flutter/material.dart';

import '../util/app_color_util.dart';
import '../util/image_path_util.dart';
import '../util/style_util.dart';

Widget subscriptionBenefitsItem(BuildContext context, String description) =>
    ListTile(
        title: Text(description, style: Theme.of(context).textTheme.bodyText2),
        leading: imageAssetCheckTrue());

Widget imageAssetCheckTrue() => Image.asset(ImagePathUtil.checkBoxImagePath);

Widget itemLinkWidget(String label, Function() onPressed) => Row(children: [
      TextButton(
          onPressed: onPressed,
          child: Text('・$label', style: underlineTextStyle)),
      const Icon(Icons.arrow_forward_ios_outlined,
          size: 18, color: Colors.white)
    ]);

Widget progressDialog() {
  return const Positioned.fill(
      top: 20,
      child: Center(
          child: CircularProgressIndicator(
              backgroundColor: AppColorUtil.appBlueDarkColor)));
}
