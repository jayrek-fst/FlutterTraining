import 'package:flutter/material.dart';

import '../util/app_color_util.dart';
import '../util/asset_path_util.dart';
import '../util/style_util.dart';

PreferredSizeWidget customAppBar(
        {required String title, required Function()? onTap}) =>
    AppBar(title: Text(title, style: appBarTitleTextStyle), actions: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: onTap,
              child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  minRadius: 18,
                  child: CircleAvatar(
                      backgroundColor: AppColorUtil.appBlueDarkColor,
                      minRadius: 16,
                      child:
                          Icon(Icons.person, color: Colors.white, size: 25)))))
    ]);

Widget subscriptionBenefitsItem(BuildContext context, String description) =>
    ListTile(
        title: Text(description, style: Theme.of(context).textTheme.bodyText2),
        leading: imageAssetCheckTrue());

Widget imageAssetCheckTrue() => Image.asset(AssetPathUtil.checkBoxImagePath);

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

Widget otherListItem(
        {required String title,
        Widget? trailing,
        bool enable = true,
        Function()? onTap}) =>
    Column(children: [
      ListTile(
          title: Text(title,
              style: TextStyle(color: enable ? Colors.white : Colors.black38)),
          trailing: trailing,
          onTap: enable ? onTap : null),
      const Divider(height: 0, thickness: 1, color: Colors.white)
    ]);

Widget circularAddIcon() => Positioned(
    top: 10,
    right: 0,
    child: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.white,
        child: CircleAvatar(
            backgroundColor: Colors.green.shade900,
            radius: 14,
            child: const Icon(Icons.add, size: 20))));
