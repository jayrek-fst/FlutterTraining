import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fumiya_flutter/common/exception/auth_exception.dart';

import '../../data/datasource/remote/auth/auth_remote_datasource_impl.dart';
import '../../data/datasource/remote/user/user_remote_datasource_impl.dart';
import '../../data/model/user_model.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../data/repository/user_repository_impl.dart';
import '../repository/auth_repository.dart';
import '../repository/user_repository.dart';

class AppUseCases {
  final AuthRepository authRepository = AuthRepositoryImpl(
      authRemoteDataSource: AuthRemoteDataSourceImpl(),
      userRemoteDataSource: UserRemoteDataSourceImpl());
  final UserRepository userRepository =
      UserRepositoryImpl(userRemoteDataSource: UserRemoteDataSourceImpl());

  Future<UserCredential> signInUseCase(
      {required String email, required String password}) async {
    try {
      return await authRepository.signIn(email: email, password: password);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future signUpUseCase(
      {required String email, required String password}) async {
    try {
      await authRepository.signUp(email: email, password: password);
      await sendEmailVerificationUseCase();
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future sendEmailVerificationUseCase() {
    try {
      return userRepository.sendEmailVerificationLink();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> isUserEmailVerifiedUseCase() async {
    try {
      return await userRepository.isUserEmailVerified();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel?> getUserInfoUseCase() async {
    try {
      return await userRepository.getUserInfo();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> saveUserInfoUseCase(UserModel userModel) async {
    try {
      await userRepository.saveUserInfo(userModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> checkUserAuthenticatedUseCase() async {
    try {
      final isVerified = await authRepository.checkUserAuthenticated();
      return isVerified ? true : false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future resetPasswordUseCase(String email) async {
    try {
      await authRepository.resetPassword(email);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> signOutUseCase() async {
    await authRepository.signOut();
  }

  Future<void> reSignInUseCase(String password) async {
    try {
      String email = await userRepository.getUserEmail();
      await signInUseCase(email: email, password: password);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> updateUserEmailUseCase(String newEmail) async {
    try {
      await userRepository.updateUserEmail(newEmail);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> updateUserPasswordUseCase(String password) async {
    try {
      await userRepository.updateUserPassword(password);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> uploadPhotoUseCase(File image) async {
    try {
      await userRepository.updatePhoto(image);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> deletePhotoUseCase() async {
    try {
      await userRepository.deletePhoto();
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }
}
