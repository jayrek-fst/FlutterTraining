import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../domain/repository/auth_repository.dart';
import '../datasource/remote/auth/auth_remote_datasource.dart';
import '../datasource/remote/auth/auth_remote_datasource_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDateSource _authRemoteDataSource = AuthRemoteDataSourceImpl();

  @override
  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    UserCredential userCredential =
        await _authRemoteDataSource.signIn(email: email, password: password);
    debugPrint('AuthRepositoryImpl: $userCredential');
    return userCredential;
  }

  @override
  Future signUp({required String email, required String password}) async {
    await _authRemoteDataSource.signUp(email: email, password: password);
  }
}
