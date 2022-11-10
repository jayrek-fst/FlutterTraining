import 'package:firebase_auth/firebase_auth.dart';

import '../../common/exception/sign_up_with_email_and_password_exception.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../data/repository/user_repository_impl.dart';

class AppUseCases {
  final _authRepository = AuthRepositoryImpl();
  final _userRepository = UserRepositoryImpl();

  Future<UserCredential> signInUseCase(
      {required String email, required String password}) async {
    return await _authRepository.signIn(email: email, password: password);
  }

  Future signUp({required String email, required String password}) async {
    try {
      await _authRepository.signUp(email: email, password: password);
      await sendEmailVerification();
    } on SignUpWithEmailAndPasswordException catch (e) {
      throw Exception(e.message);
    }
  }

  Future sendEmailVerification() {
    return _userRepository.sendEmailVerificationLink();
  }
}
