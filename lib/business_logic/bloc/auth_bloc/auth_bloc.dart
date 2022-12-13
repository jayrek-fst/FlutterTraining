import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../data/model/user_model.dart';
import '../../../domain/use_case/auth_use_case.dart';
import '../../../util/string_constants.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase appUseCases;

  AuthBloc({required this.appUseCases}) : super(AuthUserUnAuthenticated()) {
    on<CheckAuthUser>((event, emit) => _onCheckAuthUser(event, emit));
    on<SignIn>((event, emit) => _onSignedIn(event, emit));
    on<SignUp>((event, emit) => _onSignedUp(event, emit));
    on<AuthSendEmailVerification>(
        (event, emit) => _onSendEmailVerification(event, emit));
    on<SendResetPassword>((event, emit) => _onSendResetPassword(event, emit));
    on<SignOut>((event, emit) => _onSignOut(event, emit));
    on<ReSignIn>((event, emit) => _onReSignIn(event, emit));
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

  _onSignedIn(SignIn event, Emitter<AuthState> emitter) async {
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

  _onSignedUp(SignUp event, Emitter<AuthState> emitter) async {
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

  _onSendResetPassword(
      SendResetPassword event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());
    try {
      await appUseCases.resetPasswordUseCase(event.email);
      emitter(AuthPasswordEmailVerificationSent());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onSignOut(SignOut event, Emitter<AuthState> emitter) async {
    try {
      await appUseCases.signOutUseCase();
      emitter(AuthUserUnAuthenticated());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onReSignIn(ReSignIn event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());
    try {
      await appUseCases.reSignInUseCase(event.password);
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }
}
