import 'dart:io';

import 'package:app/bloc/booking/booking_bloc.dart';
import 'package:app/bloc/payment/payment_bloc.dart';
import 'package:app/bloc/payment/payment_sheets/payment_sheets.dart';
import 'package:app/common/assets.dart';
import 'package:app/common/ui/background.dart';
import 'package:app/model/my_bookings.dart';
import 'package:app/screens/bookings/book/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/styles/styles.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/edit_text.dart';
import '../../common/ui/headers.dart';

class BookingDetails extends StatefulWidget {
  final MyBookingData myBookingData;

  const BookingDetails({Key? key, required this.myBookingData}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  TextEditingController descriptionController = TextEditingController();
  var paymentIntent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(bottom: false, child: AppHeaders().collapsedHeader(text: AppConstants.serviceDetails, context: context, backNavigation: true, onFilterClick: () {})),
          Padding(
              padding: const EdgeInsets.only(left: 70.0, top: 2.0),
              child: Text((widget.myBookingData.bookingStatus == 2 ? AppConstants.completedOn : AppConstants.bookingOn) + widget.myBookingData.date.toString(), style: AppStyles.whiteText)),
          verticalSpacer(),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              width: CommonMethods.deviceWidth(),
              height: CommonMethods.deviceHeight() + CommonMethods.deviceHeight() * .42,
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
                  Expanded(child: bottomWidget()),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }

  Widget reviewWidget() => Column(
        children: [
          Text(
            "Awesome!",
            style: AppStyles.textBlueBold,
          ),
          verticalSpacer(height: 10.0),
          Text(
            "You rated even 4 stars",
            style: AppStyles.lightText,
          ),
          verticalSpacer(height: 10.0),
          RatingBar.builder(
            initialRating: 4,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 35.0,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Color(0xFFF1C21C),
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          verticalSpacer(height: 10.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppConstants.reviewHint,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: AppStyles.lightText,
            ),
          ),
          verticalSpacer(height: 10.0),
          MyEditText(
            AppConstants.descriptionText,
            false,
            TextInputType.text,
            TextCapitalization.none,
            10.0,
            descriptionController,
            Colours.hintColor.code,
            true,
            maxLine: 4,
          ),
          verticalSpacer(),
          appButton(bkColor: Colours.blue.code, text: AppConstants.submitReview, height: 50.0),
          verticalSpacer(),
        ],
      );

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
                  r"$" + "${widget.myBookingData.amount}",
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
                  r"$" + "${widget.myBookingData.gstAmount}",
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
                  r"$" + ((int.parse(widget.myBookingData.amount!)+int.parse(widget.myBookingData.gstAmount!))).toString(),
                  style: AppStyles.textBlueSemiBold,
                ),
              ],
            ),
            verticalSpacer(height: 20.0),
            if (widget.myBookingData.bookingStatus == 1) paymentWidget(),
            verticalSpacer(height: 50.0),
            if (widget.myBookingData.bookingStatus == 2)
              Column(
                children: [
                  SvgPicture.asset(Assets.thumb.name),
                  verticalSpacer(height: 10.0),
                  Text(
                    "Completed",
                    style: AppStyles.textBlueBold,
                  ),
                  verticalSpacer(height: 10.0),
                  Text((widget.myBookingData.bookingStatus == 2 ? AppConstants.completedOn : AppConstants.bookingOn) + " 20 Mar, 2021", style: AppStyles.blackText),
                ],
              ),
            // const Spacer(),
            verticalSpacer(height: 30.0),
            if (widget.myBookingData.bookingStatus == 2) reviewWidget(),
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
                  widget.myBookingData.image1!,
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
                      widget.myBookingData.businessName!,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: AppStyles.blackSemiBold,
                    ),
                    Text(
                      widget.myBookingData.bookingStatus == 1 ? AppConstants.active : AppConstants.completed,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: widget.myBookingData.bookingStatus == 1 ? AppStyles.textGreen : AppStyles.textBlue,
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
                        rating: double.parse(widget.myBookingData.rating!=null?widget.myBookingData.rating!:"5"),
                        itemSize: 18.0),
                    Text(widget.myBookingData.rating!=null?widget.myBookingData.rating!:"5")
                  ],
                ),
                Text(
                  "Joined " + widget.myBookingData.date.toString(),
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

  paymentWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _requestedUserProfile(),
   _requestedPayment()
      ],
    );
  }

  _requestedUserProfile() {
    return Row(
      children: const [
       CircleAvatar(),
        SizedBox(width: 10.0,),
        Text("Thomas")
      ],
    );
  }

  _requestedPayment() {
    return Row(
      children:  [
       ElevatedButton(onPressed: (){}, child: const Text("Cancel")),
        const SizedBox(width: 10.0,),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentOptions(totalPayment: ((int.parse(widget.myBookingData.amount!)+int.parse(widget.myBookingData.gstAmount!))).toDouble(),
          bookingId: widget.myBookingData.id.toString(),)));
        }, child: const Text("Completed")),
      ],
    );
  }


}
