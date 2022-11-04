import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import '../../util/app_color_util.dart';
import '../../util/image_path_util.dart';
import '../../util/string_constants.dart';
import '../../util/text_style_util.dart';

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
          icon: Image.asset(ImagePathUtil.mapUnselectedPath),
          activeIcon: Image.asset(ImagePathUtil.mapSelectedPath),
          label: StringConstants.map),
      BottomNavigationBarItem(
          icon: Image.asset(ImagePathUtil.parkUnselectedPath),
          activeIcon: Image.asset(ImagePathUtil.parkSelectedPath),
          label: StringConstants.park),
      BottomNavigationBarItem(
          icon: Image.asset(ImagePathUtil.stationUnselectedPath),
          activeIcon: Image.asset(ImagePathUtil.stationSelectedPath),
          label: StringConstants.station),
      BottomNavigationBarItem(
          icon: Image.asset(ImagePathUtil.baseUnselectedPath),
          activeIcon: Image.asset(ImagePathUtil.baseSelectedPath),
          label: StringConstants.base)
    ];
  }

  void _onTappedEvent(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.read<BottomNavBloc>().add(BottomNavMapEvent());
        break;
      case 1:
        context.read<BottomNavBloc>().add(BottomNavParkEvent());
        break;
      case 2:
        context.read<BottomNavBloc>().add(BottomNavStationEvent());
        break;
      case 3:
        context.read<BottomNavBloc>().add(BottomNavBaseEvent());
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
        return const Center(
            child: Text(StringConstants.map,
                style: TextStyle(color: Colors.black)));
      case NavItem.park:
        return const Center(
            child: Text(StringConstants.park,
                style: TextStyle(color: Colors.black)));
      case NavItem.station:
        return const Center(
            child: Text(StringConstants.station,
                style: TextStyle(color: Colors.black)));
      case NavItem.base:
        return const Center(
            child: Text(StringConstants.base,
                style: TextStyle(color: Colors.black)));
    }
  }
}
