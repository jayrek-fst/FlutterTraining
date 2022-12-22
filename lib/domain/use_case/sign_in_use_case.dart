import 'package:firebase_auth/firebase_auth.dart';

import '../../common/exception/auth_exception.dart';
import '../repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase({required this.authRepository});

  // final AuthRepository authRepository =
  //     AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSourceImpl());

  Future<UserCredential> invoke(
      {required String email, required String password}) async {
    try {
      return await authRepository.signIn(email: email, password: password);
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }
}
