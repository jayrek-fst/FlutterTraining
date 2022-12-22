import 'package:firebase_auth/firebase_auth.dart';

import '../../../../common/exception/auth_exception.dart';
import '../user/user_remote_datasource.dart';
import '../user/user_remote_datasource_impl.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDateSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRemoteDataSource userRemoteDataSource = UserRemoteDataSourceImpl();

  @override
  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return response;
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromCode(e.code);
    } catch (e) {
      throw const AuthException();
    }
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromCode(e.code);
    } catch (_) {
      throw const AuthException();
    }
  }

  @override
  Future<bool> checkUserAuthenticated() async {
    try {
      return await userRemoteDataSource.isUserEmailVerified();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromCode(e.code);
    } catch (_) {
      throw const AuthException();
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
