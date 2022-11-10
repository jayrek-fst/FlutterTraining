part of 'toggle_bloc.dart';

abstract class ToggleEvent extends Equatable {
  const ToggleEvent();
}

class ToggleSignedIn extends ToggleEvent {
  final ToggleSignInState toggleState;

  const ToggleSignedIn({required this.toggleState});

  @override
  List<Object?> get props => [toggleState];
}

class ToggleSignedUp extends ToggleEvent {
  final ToggleSignUpState toggleState;

  const ToggleSignedUp({required this.toggleState});

  @override
  List<Object?> get props => [toggleState];
}
