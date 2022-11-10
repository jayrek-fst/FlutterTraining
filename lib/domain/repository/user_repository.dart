import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRepository {
  Future<String> getUserUid();

  Future<String> getUserToken();

  Future<String> getUserEmail();

  Future<bool> isUserEmailVerified();

  Future sendEmailVerificationLink();

  Future<DocumentSnapshot<Object?>> getUserInfo();
}
