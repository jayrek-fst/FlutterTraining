part of 'toggle_bloc.dart';

abstract class ToggleState extends Equatable {
  const ToggleState();

  @override
  List<Object> get props => [];
}

class ToggleInitial extends ToggleState {}

class ToggleSignInState extends ToggleState {
  final bool togglePassword;

  const ToggleSignInState({required this.togglePassword});

  @override
  List<Object> get props => [togglePassword];
}

class ToggleSignUpState extends ToggleState {
  final bool togglePassword;
  final bool toggleConfirmPassword;

  const ToggleSignUpState(
      {required this.togglePassword, required this.toggleConfirmPassword});

  @override
  List<Object> get props => [togglePassword, toggleConfirmPassword];
}
