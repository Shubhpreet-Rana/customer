import 'package:app/common/assets.dart';
import 'package:app/common/ui/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/styles/styles.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/headers.dart';

class BookingDetails extends StatefulWidget {
  final Map<String, dynamic> item;

  const BookingDetails({Key? key, required this.item}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
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
                  .collapsedHeader(text: AppConstants.serviceDetails, context: context, backNavigation: true, onFilterClick: () {})),
          Padding(
              padding: const EdgeInsets.only(left: 70.0, top: 2.0),
              child: Text((widget.item['status'] == 2 ? AppConstants.completedOn : AppConstants.bookingOn) + " 20 Mar, 2021",
                  style: AppStyles.whiteText)),
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
                  centerWidget(),
                  verticalSpacer(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("28 Mar, 2022", style: AppStyles.blackSemiBold),
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
                  verticalSpacer(height: 10.0),
                  Expanded(child: bottomWidget())
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }

  Widget bottomWidget() => Container(
        color: Colors.white,
        width: CommonMethods.deviceWidth(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Oil Change",
                  style: AppStyles.lightText,
                ),
                Text(
                  r"$250",
                  style: AppStyles.blackSemiBold,
                ),
              ],
            ),
            verticalSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "GST",
                  style: AppStyles.lightText,
                ),
                Text(
                  r"$30",
                  style: AppStyles.blackSemiBold,
                ),
              ],
            ),
            verticalSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: AppStyles.blackSemiW400_1,
                ),
                Text(
                  r"$280",
                  style: AppStyles.textBlueSemiBold,
                ),
              ],
            ),
            const Spacer(),
            if (widget.item['status'] == 2)
              Column(
                children: [
                  SvgPicture.asset(Assets.thumb.name),
                  verticalSpacer(height: 10.0),
                  Text(
                    "Completed",
                    style: AppStyles.textBlueBold,
                  ),
                  verticalSpacer(height: 10.0),
                  Text((widget.item['status'] == 2 ? AppConstants.completedOn : AppConstants.bookingOn) + " 20 Mar, 2021",
                      style: AppStyles.blackText),
                ],
              ),
            const Spacer(),
            verticalSpacer(height: 10.0),
          ],
        ),
      );

  Widget centerWidget() => Container(
        color: Colors.white,
        width: CommonMethods.deviceWidth(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Oil Change",
              style: AppStyles.blackSemiBold,
            ),
            verticalSpacer(height: 10.0),
            Row(
              children: [
                Text(
                  "Castrol Oil",
                  style: AppStyles.blackBold,
                ),
                horizontalSpacer(width: 10.0),
                Text(
                  "- Engine Oil",
                  style: AppStyles.lightText,
                ),
              ],
            ),
            verticalSpacer(height: 10.0),
            Text(
              r"$250",
              style: AppStyles.textBlueSemiBold,
            ),
            verticalSpacer(height: 10.0),
            Text(
              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.",
              style: AppStyles.blackSemiW400,
            ),
          ],
        ),
      );

  Widget header() => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            SizedBox(
              width: 100.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  widget.item['image'],
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
                    Text(
                      widget.item['serviceType'],
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: AppStyles.blackSemiBold,
                    ),
                    Text(
                      widget.item['status'] == 1 ? AppConstants.active : AppConstants.completed,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: widget.item['status'] == 1 ? AppStyles.textGreen : AppStyles.textBlue,
                    )
                  ],
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
