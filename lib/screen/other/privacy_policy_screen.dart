import 'package:flutter/material.dart';
import 'package:fumiya_flutter/util/asset_path_util.dart';
import 'package:fumiya_flutter/util/string_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../util/helper_util.dart';
import '../../util/style_util.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WebViewController controller;
    return Scaffold(
        appBar:
            AppBar(title: Text(StringConstants.privacyPolicy, style: appBarTitleTextStyle)),
        body: WebView(
            initialUrl: '',
            onWebViewCreated: (WebViewController webViewController) async {
              controller = webViewController;
              await HelperUtil().loadHtmlFromAssets(
                  AssetPathUtil.privacyPolicyHtml, controller);
            }));
  }
}
