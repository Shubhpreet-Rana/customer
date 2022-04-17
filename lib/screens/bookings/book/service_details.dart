import 'package:app/screens/bookings/book/calender_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../common/methods/common.dart';
import '../../../common/styles/styles.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/headers.dart';
import '../../home/home_tabs.dart';

class ServiceDetails extends StatefulWidget {
  final Map<String, dynamic> item;

  const ServiceDetails({Key? key, required this.item}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
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
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                              color: Colors.white,
                              width: CommonMethods.deviceWidth(),
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    removeBottom: true,
                                    child: ListView.builder(
                                      itemCount: vehicles.length,
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        return ExpansionTile(
                                          title: Row(
                                            children: [
                                              SizedBox(
                                                width: 24.0,
                                                height: 24.0,
                                                child: Checkbox(
                                                    value: vehicles[i].isSelected,
                                                    checkColor: Colors.white,
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                    onChanged: (val) {
                                                      _onSelect(val, vehicles[i]);
                                                    }),
                                              ),
                                              horizontalSpacer(
                                                width: 10.0,
                                              ),
                                              Text(
                                                vehicles[i].title,
                                                style: AppStyles.blackSemiBold,
                                              ),
                                            ],
                                          ),
                                          children: <Widget>[
                                            _buildExpandableContent(vehicles[i]),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  verticalSpacer(),
                                  GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            useRootNavigator: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(20),
                                              ),
                                            ),
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            backgroundColor: Colors.white,
                                            builder: (context) {
                                              List<ServiceTypes> data = vehicles.where((element) => element.isSelected = true).toList();
                                              //print(data.length);
                                              return const SelectDate();
                                            });
                                      },
                                      child: appButton(bkColor: Colours.blue.code, text: AppConstants.bookNow, height: 50.0)),
                                  verticalSpacer(height: 100.0),
                                ],
                              )),
                        ),
                      ),
                    ],
                  )))
        ],
      )),
    );
  }

  void _onSelect(bool? newValue, ServiceTypes type) => setState(() {
        type.isSelected = newValue!;
        if (mounted) {
          setState(() {});
        }
      });

  _buildExpandableContent(ServiceTypes vehicle) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 35.0, bottom: 10.0),
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
              vehicle.price,
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

class ServiceTypes {
  bool isSelected;
  final String title;
  final String service;
  final String subService;
  final String price;
  final String description;

  ServiceTypes(this.isSelected, this.title, this.service, this.subService, this.price, this.description);
}

List<ServiceTypes> vehicles = [
  ServiceTypes(true, 'Oil Change', 'Castrool Oil', 'Engine Oil', r'$250',
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
  ServiceTypes(false, 'Gasonline', 'Castrool Oil', 'Engine Oil', r'$250',
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
  ServiceTypes(false, 'Car Wash', 'Castrool Oil', 'Engine Oil', r'$250',
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
  ServiceTypes(false, 'Auto Repair', 'Castrool Oil', 'Engine Oil', r'$250',
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
  ServiceTypes(false, 'Auto Parts', 'Castrool Oil', 'Engine Oil', r'$250',
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
  ServiceTypes(false, 'Road Side Assistance', 'Castrool Oil', 'Engine Oil', r'$250',
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
];
