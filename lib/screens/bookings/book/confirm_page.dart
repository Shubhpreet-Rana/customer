import 'package:app/screens/bookings/book/payment_options.dart';
import 'package:app/screens/bookings/book/service_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

import '../../../bloc/serviceProvider/service_provider_bloc.dart';
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
  String? selectedTime;

  ConfirmBooking({Key? key, required this.selectedServices, required this.item, required this.selectedDate, this.selectedTime}) : super(key: key);

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  String address = "";

  Future<void> getAddressFromLatLong(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      print(placemarks);
      Placemark place = placemarks[0];
      var data = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      address = data;
      setState(() {});
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  @override
  void initState() {
    super.initState();
    getAddressFromLatLong(widget.item['lat'], widget.item['long']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(bottom: false, child: AppHeaders().collapsedHeader(text: widget.item['serviceType'], context: context, backNavigation: true, onFilterClick: () {})),
            Padding(padding: const EdgeInsets.only(left: 70.0, top: 2.0), child: Text((AppConstants.servicePopularity), style: AppStyles.whiteText)),
            verticalSpacer(),
            Expanded(
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          color: Colours.lightGray.code,
                          width: CommonMethods.deviceWidth(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                                child: Text(AppConstants.serviceCategories, style: AppStyles.blackSemiBold),
                              ),
                              verticalSpacer(height: 10.0),
                              Container(
                                color: Colors.white,
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
                                              widget.selectedServices[i].title,
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
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "," + widget.selectedTime!,
                                          style: AppStyles.blackSemiBold,
                                        ),
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
                              Container(
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
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
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          widget.selectedServices[i].title,
                                                          style: AppStyles.lightText,
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                          "GST",
                                                          style: AppStyles.lightText,
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          r"$" + widget.selectedServices[i].price.toString(),
                                                          style: AppStyles.blackSemiBold,
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                          r"$" + widget.selectedServices[i].gstRate.toString(),
                                                          style: AppStyles.blackSemiBold,
                                                        )
                                                      ],
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
                                    verticalSpacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total GST",
                                          style: AppStyles.blackSemiW400_1,
                                        ),
                                        Text(
                                          r"$" + getTotalGST().toString(),
                                          style: AppStyles.textBlueBold,
                                        ),
                                      ],
                                    ),
                                    verticalSpacer(height: 50.0),
                                    BlocListener<ServiceProviderBloc, ServiceProviderState>(
                                      listener: (context, state) {
                                        if (state is BookingSuccessfully) {
                                          /*   Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(CupertinoPageRoute(
                                                    builder: (context) =>
                                                        PaymentOptions(
                                                          totalPayment:
                                                              getTotal(),
                                                        )));*/
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
                                        if (state is BookingFailed) {
                                          CommonMethods().showToast(context: context, message: state.error);
                                        }
                                      },
                                      child: BlocBuilder<ServiceProviderBloc, ServiceProviderState>(builder: (context, state) {
                                        if (state is BookServiceLoading) {
                                          return Container(
                                            width: CommonMethods.deviceWidth(),
                                            height: 55,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                                            child: const Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );
                                        }
                                        return GestureDetector(
                                            behavior: HitTestBehavior.translucent,
                                            onTap: () {
                                              var data = {
                                                "amount": getTotal(),
                                                "date": widget.selectedDate,
                                                "service_cat_id": getSelectCatIds(),
                                                "address_lat": getAddressLAT(),
                                                "address_long": getAddressLONG(),
                                                "gst_amount": getTotalGST(),
                                                "time": widget.selectedTime
                                              };
                                              BlocProvider.of<ServiceProviderBloc>(context).add(BookService(getTotal().toString(), widget.selectedDate.toString(), getAddressLAT(), getAddressLONG(),
                                                  getTotalGST().toString(), widget.selectedTime, getSelectCatIds()));

                                              /*  Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(CupertinoPageRoute(
                                                    builder: (context) =>
                                                        PaymentOptions(
                                                          totalPayment:
                                                              getTotal(),
                                                          bookingDetails: data,
                                                        )));*/
                                            },
                                            child: appButton(bkColor: Colours.blue.code, text: AppConstants.confirmBooking, height: 50.0));
                                      }),
                                    ),
                                    verticalSpacer(height: 50.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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

  double getTotal() {
    double total = 0;
    for (var item in widget.selectedServices) {
      total = total + double.parse(item.price);
    }
    return total;
  }

  double getTotalGST() {
    double total = 0;
    for (var item in widget.selectedServices) {
      total = total + double.parse(item.gstRate!);
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
            Row(
              children: [
                const Text(
                  "GST: ",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  r"$" + vehicle.gstRate.toString(),
                  style: AppStyles.textBlueSemiBold,
                ),
              ],
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
                    CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: widget.item['image'],
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
                  widget.item['serviceType'] ?? "",
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
                    Expanded(
                      child: Text(
                        address,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: AppStyles.blackText,
                      ),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      );

  getSelectCatIds() {
    List<String>? catIds = [];
    if (widget.selectedServices.isNotEmpty) {
      widget.selectedServices.forEach((element) {
        catIds.add(element.id);
      });
    }
    return catIds;
  }

  getAddressLAT() {
    String? lat;
    if (widget.selectedServices.isNotEmpty) {
      List<ServiceTypes> list = widget.selectedServices.where((element) => element.id == "6").toList();
      if (list.isNotEmpty) {
        lat = list[0].lat.toString();
      } else {
        lat = "";
      }
    }
    return lat!;
  }

  getAddressLONG() {
    String? long;
    if (widget.selectedServices.isNotEmpty) {
      List<ServiceTypes> list = widget.selectedServices.where((element) => element.id == "6").toList();
      if (list.isNotEmpty) {
        long = list[0].long.toString();
      } else {
        long = "";
      }
    }
    return long!;
  }
}
