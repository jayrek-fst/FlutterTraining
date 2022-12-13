import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../data/model/user_model.dart';
import '../../../domain/use_case/app_use_cases.dart';
import '../../../util/string_constants.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppUseCases appUseCases;

  AuthBloc({required this.appUseCases}) : super(AuthUserUnAuthenticated()) {
    on<CheckAuthUser>((event, emit) => _onCheckAuthUser(event, emit));
    on<AuthSignIn>((event, emit) => _onSignedIn(event, emit));
    on<AuthSignUp>((event, emit) => _onSignedUp(event, emit));
    on<AuthSendEmailVerification>(
        (event, emit) => _onSendEmailVerification(event, emit));
    on<UserInfoRegistration>((event, emit) => _onUserRegistration(event, emit));
    on<AuthSendResetPassword>(
        (event, emit) => _onSendResetPassword(event, emit));
    on<AuthSignOut>((event, emit) => _onSignOut(event, emit));
    on<AuthReSignIn>((event, emit) => _onReSignIn(event, emit));
    on<AuthUpdateEmail>((event, emit) => _onUpdateEmail(event, emit));
    on<AuthUpdatePassword>((event, emit) => _onUpdatePassword(event, emit));
    on<AuthUpdatePhoto>((event, emit) => _onUpdatePhoto(event, emit));
    on<AuthDeletePhoto>((event, emit) => _onDeletePhoto(event, emit));
  }

  _onCheckAuthUser(CheckAuthUser event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());
    try {
      var isAuthenticated = await appUseCases.checkUserAuthenticatedUseCase();
      if (isAuthenticated) {
        final user = await appUseCases.getUserInfoUseCase();
        user != null
            ? emitter(AuthUserAuthenticated(user: user))
            : emitter(UserInfoNotExisted());
      } else {
        emitter(AuthUserUnAuthenticated());
      }
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onSignedIn(AuthSignIn event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());

    Map<String, dynamic> formValue = event.formKey.currentState!.value;
    final email = formValue[StringConstants.email];
    final password = formValue[StringConstants.password];

    try {
      await appUseCases.signInUseCase(email: email, password: password);

      if (await appUseCases.isUserEmailVerifiedUseCase()) {
        final user = await appUseCases.getUserInfoUseCase();
        user != null
            ? emitter(AuthUserAuthenticated(user: user))
            : emitter(UserInfoNotExisted());
      } else {
        emitter(AuthUserEmailUnVerified());
      }
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onSignedUp(AuthSignUp event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());

    Map<String, dynamic> formValue = event.formKey.currentState!.value;
    final email = formValue[StringConstants.email];
    final password = formValue[StringConstants.password];

    try {
      await appUseCases.signUpUseCase(email: email, password: password);
      emitter(AuthUserUnAuthenticated());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onSendEmailVerification(
      AuthSendEmailVerification event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());

    try {
      await appUseCases.sendEmailVerificationUseCase();
      emitter(AuthEmailVerificationSent());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onUserRegistration(
      UserInfoRegistration event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());

    event.userModel.subscription = Subscription();
    event.userModel.birthDate = BirthDate();

    try {
      await appUseCases.saveUserInfoUseCase(event.userModel);
      final user = await appUseCases.getUserInfoUseCase();
      user != null
          ? emitter(AuthUserAuthenticated(user: user))
          : emitter(UserInfoNotExisted());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onSendResetPassword(
      AuthSendResetPassword event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());
    try {
      await appUseCases.resetPasswordUseCase(event.email);
      emitter(AuthPasswordEmailVerificationSent());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onSignOut(AuthSignOut event, Emitter<AuthState> emitter) async {
    try {
      await appUseCases.signOutUseCase();
      emitter(AuthUserUnAuthenticated());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onReSignIn(AuthReSignIn event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());
    try {
      await appUseCases.reSignInUseCase(event.password);
      final user = await appUseCases.getUserInfoUseCase();
      user != null
          ? emitter(AuthUserAuthenticated(user: user))
          : emitter(UserInfoNotExisted());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onUpdateEmail(AuthUpdateEmail event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());
    try {
      await appUseCases.updateUserEmailUseCase(event.email);
      await appUseCases.sendEmailVerificationUseCase();
      emitter(AuthEmailUpdated());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onUpdatePassword(
      AuthUpdatePassword event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());
    try {
      await appUseCases.updateUserPasswordUseCase(event.password);
      emitter(AutPasswordUpdated());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onUpdatePhoto(AuthUpdatePhoto event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());
    try {
      await appUseCases.uploadPhotoUseCase(event.imageFile);
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onDeletePhoto(AuthDeletePhoto event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());
    try {
      await appUseCases.deletePhotoUseCase();
      emitter(AuthPhotoDeleted());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }
}
