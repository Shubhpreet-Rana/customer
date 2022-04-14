import 'package:app/common/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/assets.dart';
import '../../../common/colors.dart';
import '../../../common/methods/common.dart';
import '../../../common/styles/styles.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/headers.dart';
import '../../bookings/booking_details.dart';

class CalenderTab extends StatefulWidget {
  const CalenderTab({Key? key}) : super(key: key);

  @override
  State<CalenderTab> createState() => _CalenderTabState();
}

class _CalenderTabState extends State<CalenderTab> {
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
                  .collapsedHeader(text: AppConstants.myBooking, context: context, backNavigation: false, onFilterClick: () {})),
          verticalSpacer(),
          Expanded(
              child: Container(
            width: CommonMethods.deviceWidth(),
            height: CommonMethods.deviceHeight(),
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 5.0, top: 40.0),
            decoration: BoxDecoration(
              color: Colours.lightGray.code,
            ),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return listItem(
                          image: Assets.service.name,
                          serviceType: "Transmission Service",
                          joinDate: "15 Mar, 2021",
                          services: ['AC Gas Change', 'Gasoline', 'Cooling Test'],
                          rating: 5,
                          status: 1);
                    } else {
                      return listItem(
                          image: Assets.service1.name,
                          serviceType: "AC Service",
                          joinDate: "15 Mar, 2021",
                          services: ['AC Gas Change', 'Gasoline', 'Cooling Test'],
                          status: 2);
                    }
                  }),
            ),
          ))
        ],
      )),
    );
  }

  Widget listItem(
          {required String image,
          required String serviceType,
          required String joinDate,
          required List<String> services,
          double rating = 4,
          required int status}) =>
      Column(
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
                    child: Image.asset(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                horizontalSpacer(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            serviceType,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: AppStyles.blackSemiBold,
                          ),
                          Text(
                            status == 1 ? AppConstants.active : AppConstants.completed,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: status == 1 ? AppStyles.textGreen : AppStyles.textBlue,
                          )
                        ],
                      ),
                      Text(
                        "Joined " + joinDate,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: AppStyles.lightText12,
                      ),
                      ListView.builder(
                          itemCount: services.length,
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
                                  services[index],
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
                Row(
                  children: [
                    RatingBarIndicator(
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Color(0xFFF1C21C),
                            ),
                        rating: rating,
                        itemSize: 18.0),
                    Text(rating.toString())
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Map<String, dynamic> item = {
                            "image": image,
                            "serviceType": serviceType,
                            "joinDate": joinDate,
                            "services": services,
                            "rating": rating,
                            "status": status
                          };
                          Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) =>  BookingDetails(item:item)));
                        },
                        child: rowButton(
                            bkColor: Colours.blue.code, text: AppConstants.details, paddingHorizontal: 8.0, paddingVertical: 7.0)),
                  ],
                ),
              ],
            ),
          )
        ],
      );
}
