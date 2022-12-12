import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fumiya_flutter/util/string_constants.dart';

import '../../../../common/exception/auth_exception.dart';
import '../../../model/user_model.dart';
import 'user_remote_datasource.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
  Future<String> getUserEmail() async {
    try {
      return await _getFirebaseUser().email;
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
      /*final settings = ActionCodeSettings(
          url: 'https://devjayrek.page.link/c2Sd',
          androidPackageName: 'com.jayrek.flutter_training',
          handleCodeInApp: true,
          androidMinimumVersion: '28',
          dynamicLinkDomain: 'devjayrek.page.link',
          iOSBundleId: 'com.jayrek.flutterTraining',
          androidInstallApp: true);
      final String email = _getFirebaseUser().email;
      await _auth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: settings);*/
      var user = await _getFirebaseUser();
      await user.sendEmailVerification();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel?> getUserInfo() async {
    try {
      final uid = _getFirebaseUser().uid;
      final ref = _firebaseFirestore
          .collection(StringConstants.userCollection)
          .doc(uid)
          .withConverter<UserModel>(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel userModel, _) => userModel.toJson());
      final docSnap = await ref.get();
      return docSnap.data();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> saveUserInfo(UserModel userModel) async {
    try {
      userModel.uid = _getFirebaseUser().uid;
      userModel.mail = _getFirebaseUser().email;
      userModel.createdAt = Timestamp.now();
      userModel.updatedAt = Timestamp.now();
      await _firebaseFirestore
          .collection(StringConstants.userCollection)
          .doc(userModel.uid)
          .set(userModel.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future updateUserEmail(String newEmail) async {
    try {
      var user = await _getFirebaseUser();
      await user.updateEmail(newEmail);

      var uid = await getUserUid();
      var email = await getUserEmail();

      var userMap = {'mail': email, 'updatedAt': Timestamp.now()};
      await _firebaseFirestore
          .collection(StringConstants.userCollection)
          .doc(uid)
          .set(userMap, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromCode(e.code);
    } catch (e) {
      throw const AuthException();
    }
  }

  @override
  Future updateUserPassword(String password) async {
    try {
      var user = await _getFirebaseUser();
      await user.updatePassword(password);
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromCode(e.code);
    } catch (e) {
      throw const AuthException();
    }
  }

  @override
  Future updatePhoto(File imageFile) async {
    try {
      var uid = await getUserUid();
      Reference reference =
          FirebaseStorage.instance.ref().child('profilePhoto/$uid/profile.jpg');
      await reference.putFile(File(imageFile.path));
      await reference.getDownloadURL().then((imageUrl) async {
        var userMap = {'icon': imageUrl, 'updatedAt': Timestamp.now()};
        await _firebaseFirestore
            .collection(StringConstants.userCollection)
            .doc(uid)
            .set(userMap, SetOptions(merge: true));
      });
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromCode(e.code);
    } catch (e) {
      throw const AuthException();
    }
  }

  @override
  Future deletePhoto() async {
    try {
      var uid = await getUserUid();
      Reference reference =
          FirebaseStorage.instance.ref().child('profilePhoto/$uid/profile.jpg');
      await reference.delete();
      var userMap = {'icon': '', 'updatedAt': Timestamp.now()};
      await _firebaseFirestore
          .collection(StringConstants.userCollection)
          .doc(uid)
          .set(userMap, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromCode(e.code);
    } catch (e) {
      throw const AuthException();
    }
  }
}
