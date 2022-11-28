part of 'password_toggle_cubit.dart';

abstract class PasswordToggleState extends Equatable {
  const PasswordToggleState();

  @override
  List<Object> get props => [];
}

class PasswordToggleAction extends PasswordToggleState {
  final bool toggle;

  const PasswordToggleAction({required this.toggle});

  @override
  List<Object> get props => [toggle];
}
