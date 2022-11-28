import 'package:fumiya_flutter/data/datasource/remote/user/user_remote_datasource.dart';
import 'package:fumiya_flutter/data/model/user_model.dart';

import '../../domain/repository/user_repository.dart';

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
  Future sendEmailVerificationLink() {
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
  Future updateUserEmail(String newEmail) async {
    await userRemoteDataSource.updateUserEmail(newEmail);
  }

  @override
  Future updateUserPassword(String password) async {
    await userRemoteDataSource.updateUserPassword(password);
  }
}
