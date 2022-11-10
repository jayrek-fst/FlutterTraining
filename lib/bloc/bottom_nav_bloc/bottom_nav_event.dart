part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object?> get props => [];
}

class BottomNavMapTapped extends BottomNavEvent {}

class BottomNavParkTapped extends BottomNavEvent {}

class BottomNavStationTapped extends BottomNavEvent {}

class BottomNavBaseTapped extends BottomNavEvent {}
