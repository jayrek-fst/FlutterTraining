class SignUpWithEmailAndPasswordException implements Exception {
  const SignUpWithEmailAndPasswordException(
      [this.message = 'An unknown exception occurred!']);

  final String message;

  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordException.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordException(
            'An account already exists for that email.');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordException(
            'Email is not valid or badly formatted.');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordException(
            'Operation is not allowed.  Please contact support.');
      case 'weak-password':
        return const SignUpWithEmailAndPasswordException(
            'Please enter a stronger password.');
      default:
        return const SignUpWithEmailAndPasswordException();
    }
  }
}
