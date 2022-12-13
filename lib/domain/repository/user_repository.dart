import 'dart:io';

import '../../data/model/user_model.dart';

abstract class UserRepository {
  Future<String> getUserUid();

  Future<String> getUserToken();

  Future<String> getUserEmail();

  Future<bool> isUserEmailVerified();

  Future<void> sendEmailVerificationLink();

  Future<UserModel?> getUserInfo();

  Future<void> saveUserInfo(UserModel userModel);

  Future<void> updateUserEmail(String newEmail);

  Future<void> updateUserPassword(String password);

  Future<void> updatePhoto(File imageFile);

  Future<void> deletePhoto();
}
