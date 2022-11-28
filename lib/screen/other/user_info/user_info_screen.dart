import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fumiya_flutter/util/route_util.dart';
import '../../../util/string_constants.dart';
import '../../../util/style_util.dart';
import '../../../widget/common_widget.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        appBar: AppBar(
            title: Text(appLocalizations.raw_common_user_information,
                style: appBarTitleTextStyle)),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                          height: 200,
                          child: Column(children: [
                            GestureDetector(
                              onTap: () {
                                debugPrint('dsf');
                              },
                              child: Stack(children: [
                                const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 60,
                                    child: Icon(Icons.person,
                                        size: 100, color: Colors.black38)),
                                circularAddIcon()
                              ])
                            ),
                            const SizedBox(height: 10),
                            const Text('jayrek tabasa'),
                            const Text('jrektest@mailinator.com')
                          ]))),
                  const Divider(height: 0, thickness: 1, color: Colors.white),
                  otherListItem(
                      title: appLocalizations.raw_common_update_user_title,
                      trailing: const Icon(Icons.arrow_forward_ios_outlined,
                          size: 18),
                      onTap: () async {}),
                  otherListItem(
                      title: appLocalizations.raw_common_update_email,
                      trailing: const Icon(Icons.arrow_forward_ios_outlined,
                          size: 18),
                      onTap: () => Navigator.of(context).pushNamed(
                          RouteUtil.reSignIn,
                          arguments: StringConstants.updateEmail)),
                  otherListItem(
                      title: appLocalizations.raw_common_update_password,
                      trailing: const Icon(Icons.arrow_forward_ios_outlined,
                          size: 18),
                      onTap: () => Navigator.of(context).pushNamed(
                          RouteUtil.reSignIn,
                          arguments: StringConstants.updatePassword))
                ]))));
  }
}
