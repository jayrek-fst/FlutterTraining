import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fumiya_flutter/domain/use_case/user_use_case.dart';

import '../../../data/model/user_model.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase userUseCase;

  UserBloc({required this.userUseCase}) : super(UserInitial()) {
    on<GetUserInfo>((event, emit) => _onGetUserInfo(event, emit));
    on<SendEmailVerification>(
        (event, emit) => _onSendEmailVerification(event, emit));
    on<SaveUserInfo>((event, emit) => _onSaveUser(event, emit));
    on<UpdateEmail>((event, emit) => _onUpdateEmail(event, emit));
    on<UpdatePassword>((event, emit) => _onUpdatePassword(event, emit));
    on<UploadPhoto>((event, emit) => _onUploadPhoto(event, emit));
    on<DeletePhoto>((event, emit) => _onDeletePhoto(event, emit));
    on<UpdateUserInfo>((event, emit) => _updateUserInfo(event, emit));
  }

  _onGetUserInfo(GetUserInfo event, Emitter<UserState> emitter) async {
    emitter(Loading());
    try {
      final user = await userUseCase.getUserInfoUseCase();
      emitter(UserInformationLoaded(userModel: user!));
    } catch (e) {
      emitter(ExceptionOccurred(e.toString()));
    }
  }

  _onSendEmailVerification(
      SendEmailVerification event, Emitter<UserState> emitter) async {
    emitter(Loading());

    try {
      await userUseCase.sendEmailVerificationUseCase();
      emitter(UserActionSuccess());
    } catch (e) {
      emitter(ExceptionOccurred(e.toString()));
    }
  }

  _onSaveUser(SaveUserInfo event, Emitter<UserState> emitter) async {
    emitter(Loading());

    event.userModel.subscription = Subscription();
    event.userModel.birthDate = BirthDate();

    try {
      await userUseCase.saveUserInfoUseCase(event.userModel);
      emitter(UserActionSuccess());
    } catch (e) {
      emitter(ExceptionOccurred(e.toString()));
    }
  }

  _onUpdateEmail(UpdateEmail event, Emitter<UserState> emitter) async {
    emitter(Loading());
    try {
      await userUseCase.updateUserEmailUseCase(event.email);
      await userUseCase.sendEmailVerificationUseCase();
      emitter(UserActionSuccess());
    } catch (e) {
      emitter(ExceptionOccurred(e.toString()));
    }
  }

  _onUpdatePassword(UpdatePassword event, Emitter<UserState> emitter) async {
    emitter(Loading());
    try {
      await userUseCase.updateUserPasswordUseCase(event.password);
      emitter(UserActionSuccess());
    } catch (e) {
      emitter(ExceptionOccurred(e.toString()));
    }
  }

  _onUploadPhoto(UploadPhoto event, Emitter<UserState> emitter) async {
    emitter(Loading());
    try {
      await userUseCase.uploadPhotoUseCase(event.imageFile);
      emitter(UserActionSuccess());
    } catch (e) {
      emitter(ExceptionOccurred(e.toString()));
    }
  }

  _onDeletePhoto(DeletePhoto event, Emitter<UserState> emitter) async {
    emitter(Loading());
    try {
      await userUseCase.deletePhotoUseCase();
      emitter(UserActionSuccess());
    } catch (e) {
      emitter(ExceptionOccurred(e.toString()));
    }
  }

  _updateUserInfo(UpdateUserInfo event, Emitter<UserState> emitter) async {
    emitter(Loading());
    try {
      await userUseCase.updateUserInfoUseCase(event.userModel);
      emitter(UserActionSuccess());
    } catch (e) {
      emitter(ExceptionOccurred(e.toString()));
    }
  }
}
