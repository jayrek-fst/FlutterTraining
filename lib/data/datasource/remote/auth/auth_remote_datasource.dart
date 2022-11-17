import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDateSource {
  Future<UserCredential> signIn(
      {required String email, required String password});

  Future signUp({required String email, required String password});

  Future<bool> checkUserAuthenticated();

  Future resetPassword(String email);
}
