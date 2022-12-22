import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_event.dart';

part 'bottom_nav_state.dart';

//enum navigation bottom items
enum NavItem { map, park, station, base }

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc()
      : super(const BottomNavInitial(navItem: NavItem.map, index: 0)) {
    on<BottomNavMapTapped>((event, emit) {
      emit(const BottomNavState(navItem: NavItem.map, index: 0));
    });
    on<BottomNavParkTapped>((event, emit) {
      emit(const BottomNavState(navItem: NavItem.park, index: 1));
    });
    on<BottomNavStationTapped>((event, emit) {
      emit(const BottomNavState(navItem: NavItem.station, index: 2));
    });
    on<BottomNavBaseTapped>((event, emit) {
      emit(const BottomNavState(navItem: NavItem.base, index: 3));
    });
  }
}
