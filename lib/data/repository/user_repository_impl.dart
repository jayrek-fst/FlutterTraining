import 'dart:io';

import '../../domain/repository/user_repository.dart';
import '../datasource/remote/user/user_remote_datasource.dart';
import '../model/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<String> getUserEmail() {
    return userRemoteDataSource.getUserEmail();
  }

  @override
  Future<String> getUserToken() {
    return userRemoteDataSource.getUserToken();
  }

  @override
  Future<String> getUserUid() {
    return userRemoteDataSource.getUserUid();
  }

  @override
  Future<bool> isUserEmailVerified() {
    return userRemoteDataSource.isUserEmailVerified();
  }

  @override
  Future<void> sendEmailVerificationLink() {
    return userRemoteDataSource.sendEmailVerificationLink();
  }

  @override
  Future<UserModel?> getUserInfo() async {
    final userInfo = await userRemoteDataSource.getUserInfo();
    return userInfo;
  }

  @override
  Future<void> saveUserInfo(UserModel userModel) async {
    await userRemoteDataSource.saveUserInfo(userModel);
  }

  @override
  Future<void> updateUserEmail(String newEmail) async {
    await userRemoteDataSource.updateUserEmail(newEmail);
  }

  @override
  Future<void> updateUserPassword(String password) async {
    await userRemoteDataSource.updateUserPassword(password);
  }

  @override
  Future<void> updatePhoto(File imageFile) async {
    await userRemoteDataSource.updatePhoto(imageFile);
  }

  @override
  Future<void> deletePhoto() async {
    await userRemoteDataSource.deletePhoto();
  }

  @override
  Future<void> updateUserInfo(UserModel userModel) async {
    await userRemoteDataSource.updateUserInfo(userModel);
  }
}
