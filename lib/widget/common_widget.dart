import 'package:flutter/material.dart';

import '../util/image_path_util.dart';

Widget subscriptionBenefitsItem(BuildContext context, String description) =>
    ListTile(title: Text(description, style: Theme.of(context).textTheme.bodyText2), leading: imageAssetCheckTrue());

Widget imageAssetCheckTrue() => Image.asset(ImagePathUtil.checkBoxImagePath);
