import 'package:app/bloc/booking/booking_bloc.dart';
import 'package:app/bloc/home/home_bloc.dart';
import 'package:app/common/assets.dart';
import 'package:app/common/colors.dart';
import 'package:app/model/banner_model.dart';
import 'package:app/model/get_banner.dart';
import 'package:app/model/my_bookings.dart';
import 'package:app/screens/marketplace/view_cars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../common/constants.dart';
import '../../../common/methods/common.dart';
import '../../../common/styles/styles.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/drop_down.dart';
import '../../../common/ui/headers.dart';
import '../../marketplace/sell_car.dart';

class HomeTab extends StatefulWidget {
  final Function changeTab;

  const HomeTab({Key? key, required this.changeTab}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController _searchController = TextEditingController();
  final List<MyBookingData> _getPopularList = [];
  final List<MyBookingData> _finalResultList = [];

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetBanner());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
                bottom: false,
                child: AppHeaders().collapsedHeader(
                    text: "",
                    context: context,
                    backNavigation: false,
                    onFilterClick: () {
                      CommonMethods().openFilters(context);
                    },
                    onNotificationClick: () {
                      CommonMethods().openNotifications(context);
                    })),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: searchBox(controller: _searchController)),
                  horizontalSpacer(),
                  Expanded(
                    child: AppDropdown(
                      bgColor: Colours.blue.code,
                      items: AppConstants.serviceItems,
                      selectedItem: AppConstants.serviceItems[0],
                      height: 44.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: CommonMethods.deviceWidth(),
                height: CommonMethods.deviceHeight(),
                decoration: BoxDecoration(
                  color: Colours.lightGray.code,
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocListener<HomeBloc, HomeState>(
                              listener: (context, state) {},
                              child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                                if (state is Loading) {
                                  return const Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: CircularProgressIndicator(),
                                  ));
                                }
                                if (state is GetBannerSuccessfully) {
                                  return itemHomeSlider(state.bannerData.topImage);
                                  /*  return CarouselSlider.builder(
                                    options: CarouselOptions(
                                      height: 200,
                                      viewportFraction: 1,
                                      enableInfiniteScroll: false,
                                      autoPlay: false,
                                      autoPlayInterval: const Duration(seconds: 4),
                                      autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                    ),
                                    itemCount: 1,
                                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                                      //     final data = imgList[itemIndex];
                                      return itemHomeSlider(state.bannerData.topImage);
                                    },
                                  );*/
                                }
                                return const SizedBox.shrink();
                              })),
                          verticalSpacer(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                            child: Text(AppConstants.sProviderText, style: AppStyles.blackSemiBold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(child: serviceProviders(icon: Assets.periodic.name, text: AppConstants.provider1)),
                                Expanded(child: serviceProviders(icon: Assets.ac.name, text: AppConstants.provider2)),
                                Expanded(child: serviceProviders(icon: Assets.tyre.name, text: AppConstants.provider3)),
                                Expanded(child: serviceProviders(icon: Assets.battery.name, text: AppConstants.provider4)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                            child: Text(AppConstants.bookingText, style: AppStyles.blackSemiBold),
                          ),
                          const SizedBox(height: 5),
                          BlocBuilder<BookingBloc, BookingState>(
                            builder: (context, bookingState) {
                              if (bookingState is GetBookingSuccessState && bookingState.myBookingList.isNotEmpty) {
                                _finalResultList.clear();
                                if (bookingState.myBookingList.length == 1) {
                                  _finalResultList.add(bookingState.myBookingList[0]);
                                } else {
                                  _finalResultList.add(bookingState.myBookingList[0]);
                                  _finalResultList.add(bookingState.myBookingList[1]);
                                }
                              }
                              if (bookingState is GetBookingLoadingState && bookingState.isLoadingInitialState) {
                                return const Center(
                                    child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(),
                                ));
                              } else if (_finalResultList.isEmpty) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text("No data found"),
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  itemCount: _finalResultList.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    MyBookingData myBookingData = _finalResultList[index];
                                    List<String> services = [];
                                    if (myBookingData.services.isNotEmpty) {
                                      for (var element in myBookingData.services) {
                                        services.add(element.serviceCategory!);
                                      }
                                    }
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(myBookingData.date!);

                                    return listItem(_finalResultList[index]);
                                  },
                                );
                              }
                            },
                          ),
                          /*  BlocListener<BookingBloc, BookingState>(
                            listener: (context, bookingState) {
                              if (bookingState.myBookingList.isNotEmpty) {
                                if (bookingState.myBookingList.length == 1) {
                                  _getPopularList = bookingState.myBookingList;
                                } else {
                                  for (int i = 0; i < 2; i++) {
                                    _getPopularList.add(bookingState.myBookingList[i]);
                                  }
                                }
                              }
                            },
                            child: Container(
                              width: CommonMethods.deviceWidth(),
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BlocBuilder<BookingBloc, BookingState>(builder: (context, bookingState) {
                                    if (bookingState is BookingLoading) {
                                      return const Center(child: SizedBox());
                                    }

                                    return _getPopularList.isNotEmpty
                                        ? ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: _getPopularList.length,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  behavior: HitTestBehavior.translucent,
                                                  onTap: () {
                                                    Navigator.of(context, rootNavigator: false)
                                                        .push(MaterialPageRoute(builder: (context) => BookingDetailsScreen(myBookingData: _getPopularList[index])));
                                                  },
                                                  child: bookingHistory(icon: Assets.periodic.name, serviceText: _getPopularList[index].businessName!, status: 1, date: '25 Mar, 2022'));
                                            })
                                        : const SizedBox();
                                  }),
                                  verticalSpacer(),
                                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                                    if (state is Loading) {
                                      return const Center(
                                          child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: CircularProgressIndicator(),
                                      ));
                                    }
                                    if (state is GetBannerSuccessfully) {
                                      var data = state.props[0] as Map<String, dynamic>;
                                      Banners? banner = Banners.fromJson(data);
                                      return Container(
                                        height: 130.0,
                                        width: CommonMethods.deviceWidth(),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20.0),
                                          child: CachedNetworkImage(
                                            imageUrl: banner.data!.bottomImage!,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  }),
                                  verticalSpacer(),
                                  verticalSpacer(height: MediaQuery.of(context).size.height * 0.075),
                                ],
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(builder: (context) => const SellCar()));
                              },
                              child: rowButton(bkColor: Colours.textBlack.code, text: AppConstants.addToSell, paddingHorizontal: 8.0)),
                          horizontalSpacer(),
                          GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(
                                  builder: (context) => const ViewCars(),
                                ));
                              },
                              child: rowButton(bkColor: Colours.blue.code, text: AppConstants.viewCars, paddingHorizontal: 8.0)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listItem(MyBookingData myBookingData) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(bottom: 5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 100.0,
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: myBookingData.image1!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                horizontalSpacer(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              myBookingData.businessName!,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.blackSemiBold,
                            ),
                          ),
                          Text(
                            _getBookingStatus(myBookingData),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: _getBookingStatusStyle(myBookingData),
                          )
                        ],
                      ),
                      Text(
                        "Joined ${DateFormat('yyyy-MM-dd').format(myBookingData.date!)}",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: AppStyles.lightText12,
                      ),
                      /* ListView.builder(
                        itemCount: myBookingData.services?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              SvgPicture.asset(
                                Assets.blueDot.name,
                                height: 8.0,
                                width: 8.0,
                              ),
                              horizontalSpacer(width: 8.0),
                              Text(
                                myBookingData.services![index].serviceCategory!,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: AppStyles.blackText,
                              ),
                            ],
                          );
                        },
                      )*/
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      );

  Widget _bookingHistory({required String icon, required String serviceText, required String date, required int status}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 25.0,
                      width: 25.0,
                      child: SvgPicture.asset(
                        icon,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  horizontalSpacer(width: 10.0),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          serviceText,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: AppStyles.blackSemiW400_1,
                        ),
                        Text(
                          "On $date",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: AppStyles.lightText,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              status == 1 ? AppConstants.active : AppConstants.completed,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: status == 1 ? AppStyles.textGreen : AppStyles.textBlue,
            )
          ],
        ),
      );

  Widget serviceProviders({required String icon, required String text}) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          widget.changeTab();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 25.0,
              fit: BoxFit.cover,
            ),
            verticalSpacer(height: 10.0),
            Text(
              text,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: AppStyles.blackSemiW400,
            )
          ],
        ),
      );

  Widget itemHomeSlider(String data) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: data,
      height: MediaQuery.of(context).size.height * 0.25,
    );
  }

  String _getBookingStatus(MyBookingData myBookingData) {
    if (myBookingData.bookingStatus == 0) {
      return AppConstants.pending;
    } else if (myBookingData.bookingStatus == 1) {
      return AppConstants.active;
    } else if (myBookingData.bookingStatus == 2) {
      return AppConstants.completed;
    } else {
      return AppConstants.cancelled;
    }
  }

  TextStyle _getBookingStatusStyle(MyBookingData myBookingData) {
    if (myBookingData.bookingStatus == 0) {
      return AppStyles.blackBold;
    } else if (myBookingData.bookingStatus == 1) {
      return AppStyles.textGreen;
    } else if (myBookingData.bookingStatus == 2) {
      return AppStyles.textBlue;
    } else {
      return AppStyles.redTextW500;
    }
  }
}
