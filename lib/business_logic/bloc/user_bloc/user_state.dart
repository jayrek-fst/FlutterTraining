part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class Loading extends UserState {}

class UserInformationLoaded extends UserState {
  const UserInformationLoaded({required this.userModel});

  final UserModel userModel;

  @override
  List<Object> get props => [userModel];}

class UserActionSuccess extends UserState {}

class ExceptionOccurred extends UserState {
  const ExceptionOccurred(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
