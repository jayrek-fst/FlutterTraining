import 'dart:io';

import '../../common/exception/auth_exception.dart';
import '../../data/datasource/remote/user/user_remote_datasource_impl.dart';
import '../../data/model/user_model.dart';
import '../../data/repository/user_repository_impl.dart';
import '../repository/user_repository.dart';

class UserUseCase {
  final UserRepository userRepository =
      UserRepositoryImpl(userRemoteDataSource: UserRemoteDataSourceImpl());

  Future<void> sendEmailVerificationUseCase() {
    try {
      return userRepository.sendEmailVerificationLink();
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

  Future<void> updateUserInfoUseCase(UserModel userModel) async {
    try {
      await userRepository.updateUserInfo(userModel);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }
}
