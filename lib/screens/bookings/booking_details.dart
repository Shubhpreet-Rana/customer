import 'package:app/bloc/feedback/feedback_bloc.dart';
import 'package:app/bloc/mark_as_complete/mark_as_complete_bloc.dart';
import 'package:app/common/assets.dart';
import 'package:app/common/ui/background.dart';
import 'package:app/model/my_bookings.dart';
import 'package:app/screens/bookings/book/payment_options.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/styles/styles.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/edit_text.dart';
import '../../common/ui/headers.dart';

class BookingDetailsScreen extends StatefulWidget {
  final MyBookingData myBookingData;

  const BookingDetailsScreen({Key? key, required this.myBookingData}) : super(key: key);

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  double _feedbackRating = 5;

  String _ratingMessage = "Good";

  @override
  void initState() {
    //_markAsCompleteBloc = context.read();
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
            child: Text(
              "Service ${_getBookingStatus(widget.myBookingData)} on ${DateFormat("yyyy-MM-dd").format(
                widget.myBookingData.date ?? DateTime.now(),
              )}",
              style: AppStyles.whiteText,
            ),
          ),
          verticalSpacer(),
          Expanded(
            child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Container(
                  width: CommonMethods.deviceWidth(),
                  height: CommonMethods.deviceHeight(),
                  decoration: BoxDecoration(color: Colours.lightGray.code),
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
                                Text(DateFormat("yyyy-MM-dd").format(widget.myBookingData.date ?? DateTime.now()), style: AppStyles.blackSemiBold),
                                horizontalSpacer(width: 10.0),
                                Text(
                                  "-   Booking Date",
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
                      Flexible(child: bottomWidget()),
                    ],
                  ),
                )),
          )
        ],
      )),
    );
  }

  Widget _reviewWidget() => Column(
        children: [
          Text(
            "$_ratingMessage!",
            style: AppStyles.textBlueBold,
          ),
          verticalSpacer(height: 10.0),
          Text(
            "You rated even ${_feedbackRating.toInt()} stars",
            style: AppStyles.lightText,
          ),
          verticalSpacer(height: 10.0),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 35.0,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Color(0xFFF1C21C),
            ),
            onRatingUpdate: (double rating) {
              _feedbackRating = rating;
              if (rating == 1.0) {
                _ratingMessage = "Bad";
              } else if (rating == 2.0) {
                _ratingMessage = "Not Good";
              } else if (rating == 3.0) {
                _ratingMessage = "Good";
              } else if (rating == 4.0) {
                _ratingMessage = "Nice";
              } else {
                _ratingMessage = "Awesome";
              }
              if (mounted) {
                setState(() {});
              }
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
            _descriptionController,
            Colours.hintColor.code,
            true,
            maxLine: 4,
          ),
          verticalSpacer(),
          BlocBuilder<AddFeedbackBloc, FeedbackState>(
            builder: (context, state) {
              if (state is FeedbackLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return appButton(
                  onTapped: () {
                    BlocProvider.of<AddFeedbackBloc>(context).add(
                      FeedBackRequestedEvent(
                        rating: _feedbackRating.toString(),
                        providerId: widget.myBookingData.userId.toString(),
                        description: _descriptionController.text,
                      ),
                    );
                  },
                  bkColor: Colours.blue.code,
                  text: AppConstants.submitReview,
                  height: 50.0,
                );
              }
            },
          ),
          verticalSpacer(),
        ],
      );

  Widget bottomWidget() => Container(
        color: Colors.white,
        width: CommonMethods.deviceWidth(),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  itemCount: widget.myBookingData.services.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (itemBuilder, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.myBookingData.services[index].serviceCategory ?? "",
                            style: AppStyles.lightText,
                          ),
                          Text(
                            r"$ " "${double.parse(widget.myBookingData.services[index].price ?? "1")}",
                            style: AppStyles.blackSemiBold,
                          ),
                        ],
                      ),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "GST",
                    style: AppStyles.lightText,
                  ),
                  Text(
                    r"$ " + double.parse(widget.myBookingData.gstAmount ?? "1").toString(),
                    style: AppStyles.blackSemiBold,
                  ),
                ],
              ),
              verticalSpacer(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: AppStyles.blackSemiW400_1,
                  ),
                  Text(
                    r"$" + (double.parse(widget.myBookingData.amount ?? "1") + double.parse(widget.myBookingData.gstAmount ?? "1")).toString(),
                    style: AppStyles.textBlueSemiBold,
                  ),
                ],
              ),
              verticalSpacer(height: 20.0),
              if (widget.myBookingData.bookingStatus == 1 || widget.myBookingData.bookingStatus == 0) paymentWidget(),
              if (widget.myBookingData.bookingStatus == 2)
                Column(
                  children: <Widget>[
                    SvgPicture.asset(Assets.thumb.name),
                    verticalSpacer(height: 10.0),
                    Text(
                      "Completed",
                      style: AppStyles.textBlueBold,
                    ),
                    verticalSpacer(height: 10.0),
                    Text(
                      "${widget.myBookingData.bookingStatus == 2 ? AppConstants.completedOn : AppConstants.bookingOn} 20 Mar, 2021",
                      style: AppStyles.blackText,
                    ),
                    verticalSpacer(height: 30.0),
                    _reviewWidget(),
                  ],
                ),
              verticalSpacer(height: 10.0),
            ],
          ),
        ),
      );

  Widget centerWidget() {
    return Container(
      color: Colors.white,
      width: CommonMethods.deviceWidth(),
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
          itemCount: widget.myBookingData.services.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.myBookingData.services[index].serviceCategory ?? "",
                  style: AppStyles.blackSemiBold,
                ),
                Text(
                  widget.myBookingData.services[index].description ?? "",
                  style: AppStyles.blackSemiW400,
                ),
                verticalSpacer()
              ],
            );
          }),
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
                child: CachedNetworkImage(
                  imageUrl: widget.myBookingData.image1!,
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
                        widget.myBookingData.businessName!,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: AppStyles.blackSemiBold,
                      ),
                    ),
                    Text(
                      _getBookingStatus(widget.myBookingData),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: _getBookingStatusStyle(widget.myBookingData),
                    )
                  ],
                ),
                if (widget.myBookingData.rating != null && widget.myBookingData.rating!.isNotEmpty)
                  Row(
                    children: [
                      RatingBarIndicator(
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Color(0xFFF1C21C),
                        ),
                        rating: double.parse(widget.myBookingData.rating!),
                        itemSize: 18.0,
                      ),
                      Text(widget.myBookingData.rating!)
                    ],
                  ),
                Text(
                  "Joined ${DateFormat("yyyy-MM-dd hh:mm:ss").format(widget.myBookingData.date ?? DateTime.now())}",
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
                    Expanded(
                      child: Text(
                        "Need addrees here from api",
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        style: AppStyles.blackText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      );

  paymentWidget() {
    return Wrap(
      children: [
        _requestedUserProfile(),
        _requestedPayment(),
      ],
    );
  }

  _requestedUserProfile() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: const [
          CircleAvatar(),
          SizedBox(width: 10.0),
          Text("Need Name of From Client"),
        ],
      ),
    );
  }

  Widget _requestedPayment() {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<MarkAsCompleteBloc, MarkAsCompleteState>(builder: (context, state) {
            if (state is MarkAsCompleteLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ElevatedButton(
                  onPressed: () {
                    context.read<MarkAsCompleteBloc>().add(
                          MarkAsCompleteRequestEvent(
                            amount: (double.parse(widget.myBookingData.amount!) + double.parse(widget.myBookingData.gstAmount!)).toString(),
                            description: "",
                            bookingId: widget.myBookingData.id!,
                            status: 3,
                          ),
                        );
                  },
                  child: const Text("Cancel"));
            }
          }),
        ),
        if (widget.myBookingData.bookingStatus == 1)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentOptions(
                          totalPayment: ((double.parse(widget.myBookingData.amount!) + double.parse(widget.myBookingData.gstAmount!))).toDouble(),
                          bookingId: widget.myBookingData.id.toString(),
                          userId: widget.myBookingData.userId.toString(),
                        ),
                      ),
                    );
                  },
                  child: const Text("Completed")),
            ),
          ),
      ],
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
