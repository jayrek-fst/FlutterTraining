part of 'bottom_nav_bloc.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object?> get props => [];
}

class BottomNavMapEvent extends BottomNavEvent {}

class BottomNavParkEvent extends BottomNavEvent {}

class BottomNavStationEvent extends BottomNavEvent {}

class BottomNavBaseEvent extends BottomNavEvent {}
