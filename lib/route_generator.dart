import 'package:flutter/material.dart';

import 'screen/dashboard/dashboard_screen.dart';
import 'screen/other/other_screen.dart';
import 'screen/other/privacy_policy_screen.dart';
import 'screen/other/terms_of_service_screen.dart';
import 'screen/other/user_info/re_sign_in_screen.dart';
import 'screen/other/user_info/update_email_screen.dart';
import 'screen/other/user_info/update_password_screen.dart';
import 'screen/other/user_info/user_info_screen.dart';
import 'screen/reset_password/reset_password_screen.dart';
import 'screen/reset_password/reset_password_verification_screen.dart';
import 'screen/sign_in/sign_in_screen.dart';
import 'screen/sign_up/sign_up_details_confirmation_screen.dart';
import 'screen/sign_up/sign_up_details_screen.dart';
import 'screen/sign_up/sign_up_screen.dart';
import 'screen/sign_up/sign_up_verification_screen.dart';
import 'screen/tutorial/splash_screen.dart';
import 'screen/tutorial/tutorial_one_screen.dart';
import 'screen/tutorial/tutorial_three_screen.dart';
import 'screen/tutorial/tutorial_two_screen.dart';
import 'util/route_animation_util.dart';
import 'util/route_util.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteUtil.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RouteUtil.tutorialOne:
        return MaterialPageRoute(builder: (_) => const TutorialOneScreen());
      case RouteUtil.tutorialTwo:
        return RouteAnimationUtil(
            child: const TutorialTwoScreen(), direction: AxisDirection.left);
      case RouteUtil.tutorialThree:
        return RouteAnimationUtil(
            child: const TutorialThreeScreen(), direction: AxisDirection.left);
      case RouteUtil.signIn:
        return RouteAnimationUtil(
            child: SignInScreen(), direction: AxisDirection.up);
      case RouteUtil.signUp:
        return RouteAnimationUtil(
            child: SignUpScreen(), direction: AxisDirection.left);
      case RouteUtil.signUpDetails:
        return RouteAnimationUtil(
            child: SignUpDetailsScreen(), direction: AxisDirection.left);
      case RouteUtil.signUpDetailsConfirmation:
        return RouteAnimationUtil(
            child: SignUpDetailsConfirmationScreen(passData: args),
            direction: AxisDirection.left);
      case RouteUtil.signUpVerification:
        return RouteAnimationUtil(
            child: const SignUpVerificationScreen(),
            direction: AxisDirection.left);
      case RouteUtil.dashboard:
        return RouteAnimationUtil(
            child: const DashboardScreen(), direction: AxisDirection.up);
      case RouteUtil.resetPassword:
        return RouteAnimationUtil(
            child: ResetPasswordScreen(type: args.toString()),
            direction: AxisDirection.left);
      case RouteUtil.resetPasswordVerification:
        return RouteAnimationUtil(
            child: ResetPasswordVerificationScreen(type: args.toString()),
            direction: AxisDirection.left);
      case RouteUtil.other:
        return RouteAnimationUtil(
            child: const OtherScreen(), direction: AxisDirection.left);
      case RouteUtil.privacyPolicy:
        return RouteAnimationUtil(
            child: const PrivacyPolicyScreen(), direction: AxisDirection.left);
      case RouteUtil.termsOfService:
        return RouteAnimationUtil(
            child: const TermsOfServiceScreen(), direction: AxisDirection.left);
      case RouteUtil.userInfo:
        return RouteAnimationUtil(
            child: const UserInfoScreen(), direction: AxisDirection.left);
      case RouteUtil.reSignIn:
        return RouteAnimationUtil(
            child: ReSignInScreen(type: args.toString()),
            direction: AxisDirection.left);
      case RouteUtil.updateEmail:
        return RouteAnimationUtil(
            child: UpdateEmailScreen(), direction: AxisDirection.left);
      case RouteUtil.updatePassword:
        return RouteAnimationUtil(
            child: UpdatePasswordScreen(), direction: AxisDirection.left);
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
