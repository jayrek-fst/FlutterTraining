import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../util/app_color_util.dart';
import '../../util/helper_util.dart';
import '../../util/route_util.dart';
import '../../util/string_constants.dart';
import '../../util/style_util.dart';
import '../../util/url_util.dart';
import '../../widget/app_version_widget.dart';
import '../../widget/common_widget.dart';

class OtherScreen extends StatelessWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: AppColorUtil.appBlueColor,
        appBar: AppBar(
            title: Text(StringConstants.other, style: appBarTitleTextStyle)),
        body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthUserUnAuthenticated) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(RouteUtil.signIn, (route) => false);
          }
        }, builder: (context, state) {
          return SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    Column(children: [
                      const Divider(
                          height: 0, thickness: 1, color: Colors.white),
                      otherListItem(
                          title: appLocalizations.raw_common_user_information,
                          trailing: const Icon(Icons.arrow_forward_ios_outlined,
                              size: 18),
                          onTap: () => Navigator.of(context)
                              .pushNamed(RouteUtil.userInfo)),
                      otherListItem(
                          enable: false,
                          title: appLocalizations.raw_common_language_setting,
                          trailing: const Icon(Icons.arrow_forward_ios_outlined,
                              size: 18)),
                      const SizedBox(height: 20),
                      otherListItem(
                          title: appLocalizations.raw_common_about_app,
                          onTap: null),
                      otherListItem(
                          title: appLocalizations.raw_other_privacy_policy,
                          trailing: const Icon(Icons.arrow_forward_ios_outlined,
                              size: 18),
                          onTap: () => Navigator.of(context)
                              .pushNamed(RouteUtil.privacyPolicy)),
                      otherListItem(
                          title: appLocalizations.raw_common_terms_of_service,
                          trailing: const Icon(Icons.arrow_forward_ios_outlined,
                              size: 18),
                          onTap: () => Navigator.of(context)
                              .pushNamed(RouteUtil.termsOfService)),
                      otherListItem(
                          title: appLocalizations.raw_common_transaction_law,
                          trailing:
                              const Icon(Icons.open_in_new_outlined, size: 18),
                          onTap: () async {
                            await HelperUtil()
                                .launchBrowserUrl(UrlUtil.transactionLawUrl);
                          }),
                      otherListItem(
                          title:
                              appLocalizations.raw_common_license_information,
                          trailing: const Icon(Icons.arrow_forward_ios_outlined,
                              size: 18),
                          onTap: () async {
                            final navigator = Navigator.of(context);
                            final packageInfo =
                                await HelperUtil().getPackageInfo();

                            navigator.push(MaterialPageRoute<void>(
                                builder: (context) => Theme(
                                    data: ThemeData(cardColor: Colors.white),
                                    child: LicensePage(
                                        applicationVersion:
                                            'v${packageInfo.version}'))));
                          }),
                      otherListItem(
                          title: appLocalizations.raw_common_faq,
                          trailing:
                              const Icon(Icons.open_in_new_outlined, size: 18),
                          onTap: () async {
                            await HelperUtil().launchBrowserUrl(UrlUtil.faqUrl);
                          }),
                      otherListItem(
                          enable: false,
                          title: appLocalizations.raw_common_withdraw_account,
                          trailing: const Icon(Icons.arrow_forward_ios_outlined,
                              size: 18),
                          onTap: () {}),
                      otherListItem(
                          title: appLocalizations.raw_common_app_version,
                          trailing: const AppVersionWidget(),
                          onTap: null)
                    ]),
                    const SizedBox(height: 20),
                    TextButton(
                        onPressed: () =>
                            context.read<AuthBloc>().add(AuthSignOut()),
                        child: Text(appLocalizations.raw_common_sign_out,
                            style: underlineTextStyle.copyWith(
                                color: AppColorUtil.appOrangeColor)))
                  ])));
        }));
  }
}
