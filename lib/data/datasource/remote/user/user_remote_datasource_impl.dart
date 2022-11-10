import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fumiya_flutter/data/datasource/remote/user/user_remote_datasource.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  _getFirebaseUser() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return user ?? 'No user found';
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> getUserUid() async {
    try {
      return _getFirebaseUser().uid;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> getUserToken() async {
    try {
      final user = _getFirebaseUser();
      return user.getIdToken(true).then((token) => token.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> getUserEmail() {
    try {
      return _getFirebaseUser().email;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> isUserEmailVerified() async {
    try {
      final bool isVerified = await _getFirebaseUser().emailVerified;
      return isVerified;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future sendEmailVerificationLink() async {
    try {
      // final settings = ActionCodeSettings(
      //     url: 'https://devjayrek.page.link/c2Sd',
      //     androidPackageName: 'com.jayrek.flutter_training',
      //     handleCodeInApp: true,
      //     androidMinimumVersion: '28',
      //     androidInstallApp: true);
      // final String email = _getFirebaseUser().email;
      // await _auth.sendSignInLinkToEmail(
      //     email: email, actionCodeSettings: settings);

      await _getFirebaseUser().sendEmailVerification();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<DocumentSnapshot<Object?>> getUserInfo() async {
    try {
      final uid = _getFirebaseUser().uid;
      return await _userCollection.doc(uid).get();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
