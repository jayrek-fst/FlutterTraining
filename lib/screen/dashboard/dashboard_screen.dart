import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import '../../util/app_color_util.dart';
import '../../util/asset_path_util.dart';
import '../../util/string_constants.dart';
import '../../util/style_util.dart';
import '../base/base_screen.dart';
import '../map/map_screen.dart';
import '../park/park_screen.dart';
import '../station/station_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar:
        BlocBuilder<BottomNavBloc, BottomNavState>(builder: (context, state) {
      return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 10,
          selectedFontSize: 16,
          unselectedFontSize: 16,
          selectedLabelStyle: bottomNavBarItemTextStyle,
          unselectedLabelStyle: bottomNavBarItemTextStyle.copyWith(
              color: AppColorUtil.appGrayColor),
          items: _navBarItems(),
          currentIndex: state.index,
          selectedItemColor: _selectedItemColor(state.index),
          onTap: (index) => _onTappedEvent(index, context));
    }), body:
        BlocBuilder<BottomNavBloc, BottomNavState>(builder: (context, state) {
      return _buildScreen(state.navItem);
    }));
  }

  List<BottomNavigationBarItem> _navBarItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Image.asset(AssetPathUtil.mapUnselectedPath),
          activeIcon: Image.asset(AssetPathUtil.mapSelectedPath),
          label: StringConstants.map),
      BottomNavigationBarItem(
          icon: Image.asset(AssetPathUtil.parkUnselectedPath),
          activeIcon: Image.asset(AssetPathUtil.parkSelectedPath),
          label: StringConstants.park),
      BottomNavigationBarItem(
          icon: Image.asset(AssetPathUtil.stationUnselectedPath),
          activeIcon: Image.asset(AssetPathUtil.stationSelectedPath),
          label: StringConstants.station),
      BottomNavigationBarItem(
          icon: Image.asset(AssetPathUtil.baseUnselectedPath),
          activeIcon: Image.asset(AssetPathUtil.baseSelectedPath),
          label: StringConstants.base)
    ];
  }

  void _onTappedEvent(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.read<BottomNavBloc>().add(BottomNavMapTapped());
        break;
      case 1:
        context.read<BottomNavBloc>().add(BottomNavParkTapped());
        break;
      case 2:
        context.read<BottomNavBloc>().add(BottomNavStationTapped());
        break;
      case 3:
        context.read<BottomNavBloc>().add(BottomNavBaseTapped());
        break;
    }
  }

  Color? _selectedItemColor(int index) {
    switch (index) {
      case 0:
        return AppColorUtil.appBlueColor;
      case 1:
        return AppColorUtil.appOrangeColor;
      case 2:
        return AppColorUtil.appGreenColor;
      case 3:
        return AppColorUtil.appBlueDarkColor;
    }
    return null;
  }

  Widget _buildScreen(NavItem item) {
    switch (item) {
      case NavItem.map:
        return const MapScreen();
      case NavItem.park:
        return const ParkScreen();
      case NavItem.station:
        return const StationScreen();
      case NavItem.base:
        return const BaseScreen();
    }
  }
}
