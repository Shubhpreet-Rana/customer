import 'package:app/bloc/booking/booking_bloc.dart';
import 'package:app/common/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../common/assets.dart';
import '../../../common/colors.dart';
import '../../../common/methods/common.dart';
import '../../../common/styles/styles.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/headers.dart';
import '../../../model/my_bookings.dart';
import '../../bookings/booking_details.dart';

class CalenderTab extends StatefulWidget {
  const CalenderTab({Key? key}) : super(key: key);

  @override
  State<CalenderTab> createState() => _CalenderTabState();
}

class _CalenderTabState extends State<CalenderTab> {
  final List<MyBookingData> _finalResultList = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(bottom: false, child: AppHeaders().collapsedHeader(text: AppConstants.myBooking, context: context, backNavigation: false, onFilterClick: () {})),
          verticalSpacer(),
          BlocBuilder<BookingBloc, BookingState>(builder: (context, bookingState) {
            if (bookingState is GetBookingSuccessState && bookingState.myBookingList.isNotEmpty) {
              _finalResultList.clear();
              _finalResultList.addAll(bookingState.myBookingList);
            }
            if (bookingState is GetBookingLoadingState && bookingState.isLoadingInitialState) {
              return Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              );
            }

            if (_finalResultList.isNotEmpty) {
              _isLoading = false;
              return Expanded(
                  child: Container(
                width: CommonMethods.deviceWidth(),
                height: CommonMethods.deviceHeight(),
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0, top: 20.0),
                decoration: BoxDecoration(
                  color: Colours.lightGray.code,
                ),
                child: NotificationListener(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && bookingState is GetBookingSuccessState && bookingState.isLastPage == 0 && !_isLoading) {
                      _isLoading = true;
                      BlocProvider.of<BookingBloc>(context).add(
                        const GetBookingListEvent(isLoadingInitialState: false, isLoadingMoreDataState: true, isPaginationStartFromFirstPage: false),
                      );
                    }
                    return false;
                  },
                  child: Stack(
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          BlocProvider.of<BookingBloc>(context).add(
                            const GetBookingListEvent(
                              isLoadingInitialState: true,
                              isLoadingMoreDataState: false,
                              isPaginationStartFromFirstPage: true,
                            ),
                          );
                        },
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          child: Column(
                            children: [
                              ListView.builder(
                                  itemCount: _finalResultList.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
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
                                  }),
                              // if (bookingState.isLoading!) const CircularProgressIndicator()
                            ],
                          ),
                        ),
                      ),
                      if (bookingState is GetBookingLoadingState && bookingState.isLoadingMoreDataState)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: SpinKitCircle(
                                color: Colors.black,
                                size: 60,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ));
            } else {
              return Expanded(
                child: Container(
                  width: CommonMethods.deviceWidth(),
                  height: CommonMethods.deviceHeight(),
                  decoration: BoxDecoration(
                    color: Colours.lightGray.code,
                  ),
                  child: const Center(
                      child: Text(
                    "No bookings found",
                    style: TextStyle(color: Colors.black),
                  )),
                ),
              );
            }
          }),
        ],
      )),
    );
  }

  Widget listItem(MyBookingData myBookingData) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              myBookingData.businessName!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
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
                      const SizedBox(height: 10),
                      ListView.builder(
                          itemCount: myBookingData.services.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
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
                                  myBookingData.services[index].serviceCategory!,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.blackText,
                                ),
                              ],
                            );
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0, top: 2.0),
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (myBookingData.rating != null && myBookingData.rating!.isNotEmpty)
                  Row(
                    children: [
                      RatingBarIndicator(
                          itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Color(0xFFF1C21C),
                              ),
                          rating: double.parse(myBookingData.rating!),
                          itemSize: 18.0),
                      Text(myBookingData.rating.toString()),
                    ],
                  ),
                const Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.of(context, rootNavigator: false).push(
                      CupertinoPageRoute(
                        builder: (context) => BookingDetailsScreen(
                          myBookingData: myBookingData,
                        ),
                      ),
                    );
                  },
                  child: rowButton(
                    bkColor: Colours.blue.code,
                    text: AppConstants.details,
                    paddingHorizontal: 8.0,
                    paddingVertical: 7.0,
                  ),
                ),
              ],
            ),
          )
        ],
      );

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
