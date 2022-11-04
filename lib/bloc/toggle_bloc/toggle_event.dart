part of 'toggle_bloc.dart';

abstract class ToggleEvent extends Equatable {
  const ToggleEvent();
}

class ToggleSignInEvent extends ToggleEvent {
  final ToggleSignInState toggleState;

  const ToggleSignInEvent({required this.toggleState});

  @override
  List<Object?> get props => [toggleState];
}

class ToggleSignUpEvent extends ToggleEvent {
  final ToggleSignUpState toggleState;

  const ToggleSignUpEvent({required this.toggleState});

  @override
  List<Object?> get props => [toggleState];
}
