import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> signIn(
      {required String email, required String password});

  Future<void> signUp({required String email, required String password});

  Future<bool> checkUserAuthenticated();

  Future<void> resetPassword(String email);

  Future<void> signOut();
}
