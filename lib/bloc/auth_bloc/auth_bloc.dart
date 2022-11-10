import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../domain/use_case/app_use_cases.dart';
import '../../util/string_constants.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppUseCases appUseCases;

  AuthBloc({required this.appUseCases}) : super(AuthUserUnAuthenticated()) {
    on<AuthSignIn>((event, emit) => _onSignedIn(event, emit));
    on<AuthSignUp>((event, emit) => _onSignedUp(event, emit));
    on<AuthSendEmailVerification>(
        (event, emit) => _onSendEmailVerification(event, emit));
  }

  _onSignedIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    Map<String, dynamic> formValue = event.formKey.currentState!.value;
    final email = formValue[StringConstants.email];
    final password = formValue[StringConstants.email];

    try {
      await appUseCases.signInUseCase(email: email, password: password);

      final isVerified = await appUseCases.isUserEmailVerified();

      if (isVerified) {
        final user = await appUseCases.getUserInfo();
        if (user.data() != null) {
          emit(AuthUserAuthenticated(user));
        } else {
          emit(UserInfoNotExisted());
        }
      } else {
        emit(AuthUserEmailUnVerified());
      }
    } catch (e) {
      emit(AuthExceptionOccurred(e.toString()));
    }
  }

  _onSignedUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    Map<String, dynamic> formValue = event.formKey.currentState!.value;
    final email = formValue[StringConstants.email];
    final password = formValue[StringConstants.email];

    try {
      await appUseCases.signUp(email: email, password: password);
      emit(AuthUserUnAuthenticated());
    } catch (e) {
      emit(AuthExceptionOccurred(e.toString()));
    }
  }

  _onSendEmailVerification(
      AuthSendEmailVerification event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await appUseCases.sendEmailVerification();
      emit(AuthEmailVerificationSent());
    } catch (e) {
      emit(AuthExceptionOccurred(e.toString()));
    }
  }
}
