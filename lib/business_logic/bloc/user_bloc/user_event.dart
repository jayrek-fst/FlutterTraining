part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class SendEmailVerification extends UserEvent {}

class SaveUserInfo extends UserEvent {
  final UserModel userModel;

  const SaveUserInfo({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class UpdateEmail extends UserEvent {
  final String email;

  const UpdateEmail({required this.email});

  @override
  List<Object?> get props => [email];
}

class UpdatePassword extends UserEvent {
  final String password;

  const UpdatePassword({required this.password});

  @override
  List<Object?> get props => [password];
}

class UploadPhoto extends UserEvent {
  final File imageFile;

  const UploadPhoto({required this.imageFile});

  @override
  List<Object?> get props => [imageFile];
}

class DeletePhoto extends UserEvent {}
