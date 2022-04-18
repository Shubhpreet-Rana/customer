import 'package:app/screens/bookings/book/payment_options.dart';
import 'package:app/screens/bookings/book/service_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../common/methods/common.dart';
import '../../../common/styles/styles.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/headers.dart';

class ConfirmBooking extends StatefulWidget {
  final List<ServiceTypes> selectedServices;
  final Map<String, dynamic> item;
  final DateTime selectedDate;

  const ConfirmBooking({Key? key, required this.selectedServices, required this.item, required this.selectedDate}) : super(key: key);

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
              bottom: false,
              child: AppHeaders()
                  .collapsedHeader(text: widget.item['serviceType'], context: context, backNavigation: true, onFilterClick: () {})),
          Padding(
              padding: const EdgeInsets.only(left: 70.0, top: 2.0),
              child: Text((AppConstants.servicePopularity), style: AppStyles.whiteText)),
          verticalSpacer(),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
                width: CommonMethods.deviceWidth(),
                height: CommonMethods.deviceHeight(),
                decoration: BoxDecoration(
                  color: Colours.lightGray.code,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header(),
                    verticalSpacer(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                      child: Text(AppConstants.serviceCategories, style: AppStyles.blackSemiBold),
                    ),
                    verticalSpacer(height: 10.0),
                    Container(
                      color: Colors.white,
                      width: CommonMethods.deviceWidth(),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: true,
                          child: ListView.builder(
                              itemCount: widget.selectedServices.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                return ExpansionTile(
                                  title: Text(
                                    vehicles[i].title,
                                    style: AppStyles.blackSemiBold,
                                  ),
                                  children: <Widget>[
                                    _buildExpandableContent(widget.selectedServices[i]),
                                  ],
                                );
                              })),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(DateFormat('dd MMM, yyyy').format(widget.selectedDate), style: AppStyles.blackSemiBold),
                              horizontalSpacer(width: 10.0),
                              Text(
                                "- Booking Date",
                                style: AppStyles.lightText,
                              ),
                            ],
                          ),
                          Icon(
                            Icons.calendar_month,
                            color: Colours.blue.code,
                            size: 30.0,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.white,
                      width: CommonMethods.deviceWidth(),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: [
                          MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              removeBottom: true,
                              child: ListView.builder(
                                  itemCount: widget.selectedServices.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.selectedServices[i].title,
                                            style: AppStyles.lightText,
                                          ),
                                          Text(
                                            r"$" + widget.selectedServices[i].price.toString(),
                                            style: AppStyles.blackSemiBold,
                                          ),
                                        ],
                                      ),
                                    );
                                  })),
                          verticalSpacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: AppStyles.blackSemiW400_1,
                              ),
                              Text(
                                r"$" + getTotal().toString(),
                                style: AppStyles.textBlueBold,
                              ),
                            ],
                          ),
                          verticalSpacer(height: 50.0),
                          GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
                                    builder: (context) => PaymentOptions(
                                          totalPayment: getTotal(),
                                        )));
                              },
                              child: appButton(bkColor: Colours.blue.code, text: AppConstants.confirmBooking, height: 50.0)),
                          const Spacer(),
                        ],
                      ),
                    ))
                  ],
                )),
          )),
        ],
      )),
    );
  }

  double getTotal() {
    double total = 0;
    for (var item in widget.selectedServices) {
      total = total + item.price;
    }
    return total;
  }

  _buildExpandableContent(ServiceTypes vehicle) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  vehicle.service,
                  style: AppStyles.blackBold,
                ),
                Text(
                  "- " + vehicle.subService,
                  style: AppStyles.lightText,
                ),
              ],
            ),
            verticalSpacer(height: 5.0),
            Text(
              r"$" + vehicle.price.toString(),
              style: AppStyles.textBlueSemiBold,
            ),
            verticalSpacer(height: 10.0),
            Text(
              vehicle.description,
              style: AppStyles.blackSemiW400,
            ),
          ],
        ),
      ),
    );
  }

  Widget header() => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            SizedBox(
              width: 100.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Stack(
                  children: [
                    Image.asset(
                      widget.item['image'],
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                        right: 2.0,
                        bottom: 0.0,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(color: Colors.black.withOpacity(.5), shape: BoxShape.circle),
                          child: Text(
                            widget.item['rating'].toString(),
                            style: AppStyles.whiteTextW500,
                          ),
                        ))
                  ],
                ),
              ),
            ),
            horizontalSpacer(width: 10.0),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppConstants.serviceType,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppStyles.blackSemiBold,
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Color(0xFFF1C21C),
                            ),
                        rating: widget.item['rating'],
                        itemSize: 18.0),
                    Text(widget.item['rating'].toString())
                  ],
                ),
                Text(
                  "Joined " + widget.item['joinDate'],
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppStyles.lightText12,
                ),
                verticalSpacer(height: 10.0),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Colours.unSelectTab.code,
                    ),
                    Text(
                      "China town, Down street, \nCalifornia",
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: AppStyles.blackText,
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      );
}
