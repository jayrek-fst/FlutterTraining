import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repository/auth_repository.dart';
import '../datasource/remote/auth/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDateSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    UserCredential userCredential =
        await authRemoteDataSource.signIn(email: email, password: password);
    return userCredential;
  }

  @override
  Future signUp({required String email, required String password}) async {
    await authRemoteDataSource.signUp(email: email, password: password);
  }

  @override
  Future<bool> checkUserAuthenticated() async {
    return await authRemoteDataSource.checkUserAuthenticated();
  }

  @override
  Future resetPassword(String email) async {
    await authRemoteDataSource.resetPassword(email);
  }
}
