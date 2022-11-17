import 'package:firebase_auth/firebase_auth.dart';
import 'package:fumiya_flutter/common/exception/send_reset_password_exception.dart';

import '../../common/exception/sign_in_with_email_and_password_exception.dart';
import '../../common/exception/sign_up_with_email_and_password_exception.dart';
import '../../data/model/user_model.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../data/repository/user_repository_impl.dart';

class AppUseCases {
  final AuthRepositoryImpl authRepository;
  final UserRepositoryImpl userRepository;

  AppUseCases({required this.authRepository, required this.userRepository});

  Future<UserCredential> signInUseCase(
      {required String email, required String password}) async {
    try {
      return await authRepository.signIn(email: email, password: password);
    } on SignInWithEmailAndPasswordException catch (e) {
      throw Exception(e.message);
    }
  }

  Future signUp({required String email, required String password}) async {
    try {
      await authRepository.signUp(email: email, password: password);
      await sendEmailVerification();
    } on SignUpWithEmailAndPasswordException catch (e) {
      throw Exception(e.message);
    }
  }

  Future sendEmailVerification() {
    try {
      return userRepository.sendEmailVerificationLink();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> isUserEmailVerified() async {
    try {
      return await userRepository.isUserEmailVerified();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel?> getUserInfo() async {
    try {
      return await userRepository.getUserInfo();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> saveUserInfo(UserModel userModel) async {
    try {
      await userRepository.saveUserInfo(userModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> checkUserAuthenticated() async {
    try {
      final isVerified = await authRepository.checkUserAuthenticated();
      return isVerified ? true : false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      await authRepository.resetPassword(email);
    } on SendResetPasswordException catch (e) {
      throw Exception(e.message);
    }
  }
}
