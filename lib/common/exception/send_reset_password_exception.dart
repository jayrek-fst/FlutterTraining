class SendResetPasswordException implements Exception {
  const SendResetPasswordException(
      [this.message = 'An unknown exception occurred!']);

  final String message;

  factory SendResetPasswordException.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SendResetPasswordException(
            'Email is not valid or badly formatted.');
      case 'user-disabled':
        return const SendResetPasswordException(
            'This user has been disabled. Please contact support for help.');
      case 'user-not-found':
        return const SendResetPasswordException(
            'Email is not found, please create an account.');
      default:
        return const SendResetPasswordException();
    }
  }
}
