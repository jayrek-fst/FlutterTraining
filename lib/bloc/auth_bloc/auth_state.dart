part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {}

class AuthUserUnAuthenticated extends AuthState {}

class AuthUserAuthenticated extends AuthState {
  const AuthUserAuthenticated(this.user);

  final DocumentSnapshot<Object?> user;

  @override
  List<Object> get props => [user];
}

class AuthUserEmailUnVerified extends AuthState {}

class AuthExceptionOccurred extends AuthState {
  const AuthExceptionOccurred(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class AuthEmailVerificationSent extends AuthState {}

class UserInfoNotExisted extends AuthState {}
