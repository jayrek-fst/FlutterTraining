import 'package:flutter/material.dart';

import 'screen/dashboard/dashboard_screen.dart';
import 'screen/reset_password/reset_password_screen.dart';
import 'screen/reset_password/reset_password_verification_screen.dart';
import 'screen/sign_in/sign_in_screen.dart';
import 'screen/sign_up/sign_up_screen.dart';
import 'screen/sign_up/sign_up_verification_screen.dart';
import 'screen/tutorial/tutorial_one_screen.dart';
import 'screen/tutorial/tutorial_three_screen.dart';
import 'screen/tutorial/tutorial_two_screen.dart';
import 'util/route_animation_util.dart';
import 'util/route_util.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
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
      case RouteUtil.signUpVerification:
        return RouteAnimationUtil(
            child: const SignUpVerificationScreen(),
            direction: AxisDirection.left);
      case RouteUtil.dashboard:
        return RouteAnimationUtil(
            child: const DashboardScreen(), direction: AxisDirection.up);
      case RouteUtil.resetPassword:
        return RouteAnimationUtil(
            child: ResetPasswordScreen(), direction: AxisDirection.left);
      case RouteUtil.resetPasswordVerification:
        return RouteAnimationUtil(
            child: const ResetPasswordVerificationScreen(),
            direction: AxisDirection.left);
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
