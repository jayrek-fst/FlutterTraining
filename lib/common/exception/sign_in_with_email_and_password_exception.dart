class SignInWithEmailAndPasswordException implements Exception {
  const SignInWithEmailAndPasswordException(
      [this.message = 'An unknown exception occurred!']);

  final String message;

  ///https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
  factory SignInWithEmailAndPasswordException.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailAndPasswordException(
            'Email is not valid or badly formatted.');
      case 'user-disabled':
        return const SignInWithEmailAndPasswordException(
            'This user has been disabled. Please contact support for help.');
      case 'user-not-found':
        return const SignInWithEmailAndPasswordException(
            'Email is not found, please create an account.');
      case 'wrong-password':
        return const SignInWithEmailAndPasswordException(
            'Incorrect password, please try again.');
      case 'too-many-requests':
        return const SignInWithEmailAndPasswordException(
            'Too many requests, please try again later.');
      default:
        return const SignInWithEmailAndPasswordException();
    }
  }
}
