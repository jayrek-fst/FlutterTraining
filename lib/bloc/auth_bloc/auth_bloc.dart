import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fumiya_flutter/data/model/user_model.dart';

import '../../domain/use_case/app_use_cases.dart';
import '../../util/string_constants.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppUseCases appUseCases;

  AuthBloc({required this.appUseCases}) : super(AuthUserUnAuthenticated()) {
    on<CheckAuthUser>((event, emit) => _checkAuthUser(event, emit));
    on<AuthSignIn>((event, emit) => _onSignedIn(event, emit));
    on<AuthSignUp>((event, emit) => _onSignedUp(event, emit));
    on<AuthSendEmailVerification>(
        (event, emit) => _onSendEmailVerification(event, emit));
    on<UserInfoRegistration>((event, emit) => _onUserRegistration(event, emit));
    on<AuthSendResetPassword>(
        (event, emit) => _onSendResetPassword(event, emit));
  }

  _checkAuthUser(CheckAuthUser event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());
    try {
      await appUseCases.checkUserAuthenticated()
          ? emitter(AuthUserAuthenticated())
          : emitter(AuthUserUnAuthenticated());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onSignedIn(AuthSignIn event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());

    Map<String, dynamic> formValue = event.formKey.currentState!.value;
    final email = formValue[StringConstants.email];
    final password = formValue[StringConstants.email];

    try {
      await appUseCases.signInUseCase(email: email, password: password);

      if (await appUseCases.isUserEmailVerified()) {
        final user = await appUseCases.getUserInfo();
        user != null
            ? emitter(AuthUserAuthenticated())
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
    final password = formValue[StringConstants.email];

    try {
      await appUseCases.signUp(email: email, password: password);
      emitter(AuthUserUnAuthenticated());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onSendEmailVerification(
      AuthSendEmailVerification event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());

    try {
      await appUseCases.sendEmailVerification();
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
      await appUseCases.saveUserInfo(event.userModel);
      emitter(AuthUserAuthenticated());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  _onSendResetPassword(
      AuthSendResetPassword event, Emitter<AuthState> emitter) async {
    emitter(AuthLoading());
    try {
      await appUseCases.resetPassword(event.email);
      emitter(AuthPasswordEmailVerificationSent());
    } catch (e) {
      emitter(AuthExceptionOccurred(e.toString()));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
