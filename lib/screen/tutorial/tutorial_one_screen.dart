import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fumiya_flutter/bloc/auth_bloc/auth_bloc.dart';
import 'package:fumiya_flutter/domain/use_case/app_use_cases.dart';
import 'package:fumiya_flutter/util/app_color_util.dart';
import 'package:fumiya_flutter/util/route_util.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/datasource/remote/auth/auth_remote_datasource_impl.dart';
import '../../data/datasource/remote/user/user_remote_datasource_impl.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../data/repository/user_repository_impl.dart';
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
        body: SafeArea(
            child: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
          appUseCases: AppUseCases(
              authRepository: AuthRepositoryImpl(
                  authRemoteDataSource: AuthRemoteDataSourceImpl()),
              userRepository: UserRepositoryImpl(
                  userRemoteDataSource: UserRemoteDataSourceImpl())))
        ..add(CheckAuthUser()),
      child: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              color: AppColorUtil.appBlueColor,
              child: Column(children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    color: Colors.white,
                    child: Image.asset(ImagePathUtil.appImagePath)),
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
                        ])))
              ])))
    )));
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
