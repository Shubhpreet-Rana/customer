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
import '../../bloc/booking/booking_bloc.dart';
import '../../bloc/vehicle/view/vehicle_bloc.dart';
import '../../common/notification_services/notifications_services.dart';

final homeScreen = GlobalKey<NavigatorState>();
final carScreen = GlobalKey<NavigatorState>();
final calenderScreen = GlobalKey<NavigatorState>();
final settingsScreen = GlobalKey<NavigatorState>();

class HomeTabs extends StatefulWidget {
  const HomeTabs({Key? key}) : super(key: key);

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> with TickerProviderStateMixin<HomeTabs> {
  int _selectedTabIndex = 0;

  @override
  void initState() {


    BlocProvider.of<BookingBloc>(context).add(
      const GetBookingListEvent(
        isLoadingInitialState: true,
        isLoadingMoreDataState: false,
        isPaginationStartFromFirstPage: true,
      ),
    );
    BlocProvider.of<ServiceProviderBloc>(context).add(GetCategoryList());
    BlocProvider.of<ServiceProviderBloc>(context).add(const AllServiceProviderList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NotificationServices.instance.getDeviceToken.then((value) => print(value));
    context.read<VehicleBloc>().add(VehicleFetchEvent());
    return Scaffold(
      body: IndexedStack(
        index: _selectedTabIndex,
        children: <Widget>[
          Navigator(
            key: homeScreen,
            onGenerateRoute: (route) => CupertinoPageRoute(
                settings: route,
                builder: (context) {
                  return HomeTab(
                    changeTab: () {
                      setState(() {
                        _selectedTabIndex = 1;
                      });
                    },
                  );
                }),
          ),
          Navigator(
            key: carScreen,
            onGenerateRoute: (route) => CupertinoPageRoute(
              settings: route,
              builder: (context) => const CarTab(),
            ),
          ),
          Navigator(
            key: calenderScreen,
            onGenerateRoute: (route) => CupertinoPageRoute(
              settings: route,
              builder: (context) {
                return const CalenderTab();
              },
            ),
          ),
          Navigator(
            key: settingsScreen,
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
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(int val, BuildContext context) {
    if (_selectedTabIndex == val) {
      switch (val) {
        case 0:
          homeScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 1:
          carScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 2:
          calenderScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        case 3:
          settingsScreen.currentState!.popUntil((route) => route.isFirst);
          break;
        default:
          break;
      }
    } else {
      if (mounted) {
        setState(() {
          _selectedTabIndex = val;
        });
      }
    }
  }
}
