import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_toggle_state.dart';

class PasswordToggleCubit extends Cubit<PasswordToggleState> {
  PasswordToggleCubit() : super(const PasswordToggleAction(toggle: true));

  void passwordToggle(bool toggle) {
    emit(PasswordToggleAction(toggle: toggle));
  }
}
