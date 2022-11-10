part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthSignIn extends AuthEvent {
  final GlobalKey<FormBuilderState> formKey;

  const AuthSignIn({required this.formKey});
}

class AuthSignUp extends AuthEvent {
  final GlobalKey<FormBuilderState> formKey;

  const AuthSignUp({required this.formKey});
}

class AuthSendEmailVerification extends AuthEvent {}
