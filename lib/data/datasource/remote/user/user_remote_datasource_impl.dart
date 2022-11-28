import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      final ref = _firebaseFirestore.collection('users').doc(uid).withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel userModel, _) => userModel.toFirestore());
      final docSnap = await ref.get();
      UserModel? user = docSnap.data(); // Convert to City object
      // if (city != null) {
      //   print(city);
      // } else {
      //   print("No such document.");
      // }
      //
      //
      // final uid = _getFirebaseUser().uid;
      //  var snapshot = await _userCollection.doc(uid).get();
      //  final userModel = snapshot.data() as Map<String, dynamic>;

      return user;
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
          .collection('users')
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
          .collection('users')
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
}
