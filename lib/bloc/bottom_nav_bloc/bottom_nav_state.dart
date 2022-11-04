part of 'bottom_nav_bloc.dart';

class BottomNavState extends Equatable {
  const BottomNavState({required this.navItem, required this.index});

  final NavItem navItem;
  final int index;

  @override
  List<Object> get props => [navItem, index];
}

class BottomNavInitial extends BottomNavState {
  const BottomNavInitial({required NavItem navItem, required int index})
      : super(navItem: navItem, index: index);
}
