import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'toggle_event.dart';

part 'toggle_state.dart';

class ToggleBloc extends Bloc<ToggleEvent, ToggleState> {
  ToggleBloc() : super(ToggleInitial()) {
    on<ToggleSignUpEvent>((event, emit) {
      emit(event.toggleState);
    });
    on<ToggleSignInEvent>((event, emit) {
      emit(event.toggleState);
    });
  }
}
