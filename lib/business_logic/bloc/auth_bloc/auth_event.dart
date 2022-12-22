part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthUser extends AuthEvent {}

class SignIn extends AuthEvent {
  final GlobalKey<FormBuilderState> formKey;

  const SignIn({required this.formKey});

  @override
  List<Object?> get props => [formKey];
}

class SignUp extends AuthEvent {
  final GlobalKey<FormBuilderState> formKey;

  const SignUp({required this.formKey});

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

class SendResetPassword extends AuthEvent {
  final String email;

  const SendResetPassword({required this.email});

  @override
  List<Object?> get props => [email];
}

class SignOut extends AuthEvent {}

class ReSignIn extends AuthEvent {
  final String password;

  const ReSignIn({required this.password});

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

class AuthUpdatePhoto extends AuthEvent {
  final File imageFile;

  const AuthUpdatePhoto({required this.imageFile});

  @override
  List<Object?> get props => [imageFile];
}

class AuthDeletePhoto extends AuthEvent {}
