import 'package:firebase_auth/firebase_auth.dart';
import 'package:fumiya_flutter/common/exception/send_reset_password_exception.dart';
import 'package:fumiya_flutter/common/exception/sign_in_with_email_and_password_exception.dart';
import 'package:fumiya_flutter/data/datasource/remote/user/user_remote_datasource_impl.dart';

import '../../../../common/exception/sign_up_with_email_and_password_exception.dart';
import '../user/user_remote_datasource.dart';
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
      throw SignInWithEmailAndPasswordException.fromCode(e.code);
    } catch (_) {
      throw const SignInWithEmailAndPasswordException();
    }
  }

  @override
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordException.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordException();
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
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw SendResetPasswordException.fromCode(e.code);
    } catch (_) {
      throw const SendResetPasswordException();
    }
  }
}
