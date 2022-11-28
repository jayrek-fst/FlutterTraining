class AuthException implements Exception {
  const AuthException([this.message = 'An unknown exception occurred!']);

  final String message;

  factory AuthException.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const AuthException(
            'Email is not valid or badly formatted.');
      case 'user-disabled':
        return const AuthException(
            'This user has been disabled. Please contact support for help.');
      case 'user-not-found':
        return const AuthException(
            'Email is not found, please create an account.');
      case 'wrong-password':
        return const AuthException('Incorrect password, please try again.');
      case 'too-many-requests':
        return const AuthException(
            'Too many requests, please try again later.');
      case 'email-already-in-use':
        return const AuthException(
            'An account already exists for that email.');
      case 'operation-not-allowed':
        return const AuthException(
            'Operation is not allowed.  Please contact support.');
      case 'weak-password':
        return const AuthException('Please enter a stronger password.');
      default:
        return const AuthException();
    }
  }
}
