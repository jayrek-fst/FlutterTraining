import 'dart:io';

import '../../data/model/user_model.dart';

abstract class UserRepository {
  Future<String> getUserUid();

  Future<String> getUserToken();

  Future<String> getUserEmail();

  Future<bool> isUserEmailVerified();

  Future sendEmailVerificationLink();

  Future<UserModel?> getUserInfo();

  Future<void> saveUserInfo(UserModel userModel);

  Future updateUserEmail(String newEmail);

  Future updateUserPassword(String password);

  Future updatePhoto(File imageFile);

  Future deletePhoto();
}
