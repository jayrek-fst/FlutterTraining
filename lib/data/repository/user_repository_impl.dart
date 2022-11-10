import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fumiya_flutter/data/datasource/remote/user/user_remote_datasource.dart';
import 'package:fumiya_flutter/data/datasource/remote/user/user_remote_datasource_impl.dart';

import '../../domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource = UserRemoteDataSourceImpl();

  @override
  Future<String> getUserEmail() {
    return _userRemoteDataSource.getUserEmail();
  }

  @override
  Future<String> getUserToken() {
    return _userRemoteDataSource.getUserToken();
  }

  @override
  Future<String> getUserUid() {
    return _userRemoteDataSource.getUserUid();
  }

  @override
  Future<bool> isUserEmailVerified() {
    return _userRemoteDataSource.isUserEmailVerified();
  }

  @override
  Future sendEmailVerificationLink() {
    return _userRemoteDataSource.sendEmailVerificationLink();
  }

  @override
  Future<DocumentSnapshot<Object?>> getUserInfo() async {
    final userInfo = await _userRemoteDataSource.getUserInfo();
    return userInfo;
  }
}
