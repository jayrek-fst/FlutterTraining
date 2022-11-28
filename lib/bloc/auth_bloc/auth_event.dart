part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthUser extends AuthEvent {}

class AuthSignIn extends AuthEvent {
  final GlobalKey<FormBuilderState> formKey;

  const AuthSignIn({required this.formKey});

  @override
  List<Object?> get props => [formKey];
}

class AuthSignUp extends AuthEvent {
  final GlobalKey<FormBuilderState> formKey;

  const AuthSignUp({required this.formKey});

  @override
  List<Object?> get props => [formKey];
}

class AuthSendEmailVerification extends AuthEvent {}

class UserInfoRegistration extends AuthEvent {
  final UserModel userModel;

  const UserInfoRegistration({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class AuthSendResetPassword extends AuthEvent {
  final String email;

  const AuthSendResetPassword({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthSignOut extends AuthEvent {}

class AuthReSignIn extends AuthEvent {
  final String password;

  const AuthReSignIn({required this.password});

  @override
  List<Object?> get props => [password];
}

class AuthUpdateEmail extends AuthEvent {
  final String email;

  const AuthUpdateEmail({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthUpdatePassword extends AuthEvent {
  final String password;

  const AuthUpdatePassword({required this.password});

  @override
  List<Object?> get props => [password];
}
