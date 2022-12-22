import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../util/route_util.dart';
import '../../util/string_constants.dart';
import '../../util/url_util.dart';
import '../../widget/common_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
            title: StringConstants.map,
            onTap: () => Navigator.of(context).pushNamed(RouteUtil.other)),
        body: const WebView(
            initialUrl: UrlUtil.homeStandAloneUrl,
            javascriptMode: JavascriptMode.unrestricted));
  }
}
