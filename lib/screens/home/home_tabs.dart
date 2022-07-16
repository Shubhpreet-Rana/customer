import 'package:app/bloc/serviceProvider/service_provider_bloc.dart';
import 'package:app/common/assets.dart';
import 'package:app/common/colors.dart';
import 'package:app/screens/home/pages/calender.dart';
import 'package:app/screens/home/pages/cars.dart';
import 'package:app/screens/home/pages/home.dart';
import 'package:app/screens/home/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/vehicle/view/vehicle_bloc.dart';
import '../../common/constants.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/headers.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({Key? key}) : super(key: key);

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> with TickerProviderStateMixin<HomeTabs> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _homeScreen = GlobalKey<NavigatorState>();
  final _carScreen = GlobalKey<NavigatorState>();
  final _calenderScreen = GlobalKey<NavigatorState>();
  final _settingsScreen = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    context.read<VehicleBloc>().add(VehicleFetchEvent());
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedTabIndex,
        children: <Widget>[
          Navigator(
            key: _homeScreen,
            onGenerateRoute: (route) => CupertinoPageRoute(
              settings: route,
              builder: (context) => HomeTab(
                changeTab: () {
                  setState(() {
                    _selectedTabIndex = 1;
                  });
                },
              ),
            ),
          ),
          Navigator(
            key: _carScreen,
            onGenerateRoute: (route) => CupertinoPageRoute(
              settings: route,
              builder: (context) =>  CarTab(),
            ),
          ),
          Navigator(
            key: _calenderScreen,
            onGenerateRoute: (route) => CupertinoPageRoute(
              settings: route,
              builder: (context) => const CalenderTab(),
            ),
          ),
          Navigator(
            key: _settingsScreen,
            onGenerateRoute: (route) => CupertinoPageRoute(
              settings: route,
              builder: (context) => const ProfileTab(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedTabIndex,
              onTap: (val) => _onTap(val, context),
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: Colours.blue.code,
              unselectedItemColor: Colours.unSelectTab.code,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _selectedTabIndex == 0 ? Assets.selectedHome.name : Assets.home.name,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _selectedTabIndex == 1 ? Assets.selectedCar.name : Assets.car.name,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _selectedTabIndex == 2 ? Assets.selectedCalender.name : Assets.calender.name,
                  ),
                  label: '',
                ),
                const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      size: 30.0,
                    ),
                    label: ''),
              ],
            ),
          )),
    );
  }

  void _onTap(int val, BuildContext context) {
    if (_selectedTabIndex == val) {
      switch (val) {
        case 0:
          _homeScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 1:
          _carScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 2:
          _calenderScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 3:
          _settingsScreen.currentState!.popUntil((route) => route.isFirst);
          break;

        default:
      }
    } else {
      if (mounted) {
        setState(() {
          _selectedTabIndex = val;
        });
        if(_selectedTabIndex==1){
          BlocProvider.of<ServiceProviderBloc>(context)
              .add(AllServiceProviderList("", "", "",{}));
        }
      }
    }
  }
}
