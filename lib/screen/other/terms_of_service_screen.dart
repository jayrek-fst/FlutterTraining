import 'package:flutter/material.dart';
import 'package:fumiya_flutter/util/string_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../util/asset_path_util.dart';
import '../../util/helper_util.dart';
import '../../util/style_util.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WebViewController controller;
    return Scaffold(
        appBar: AppBar(
            title: Text(StringConstants.termsOfService,
                style: appBarTitleTextStyle)),
        body: WebView(
            initialUrl: '',
            onWebViewCreated: (WebViewController webViewController) async {
              controller = webViewController;
              await HelperUtil().loadHtmlFromAssets(
                  AssetPathUtil.termsOfServiceHtml, controller);
            }));
  }
}
