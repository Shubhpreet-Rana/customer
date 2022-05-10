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
import '../../maps/maps_page.dart';

class ServiceDetails extends StatefulWidget {
  final Map<String, dynamic> item;

  const ServiceDetails({Key? key, required this.item}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  List<ServiceTypes> selectedServices = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedServices.add(vehicles[0]);
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
                                      onTap: () async {
                                        if (getButtonColor() == Colours.blue.code) {
                                          var list = selectedServices.where((element) => element.id == "6").toList();
                                          if (list.isNotEmpty) {
                                            resetServices();
                                            Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(builder: (context) => const MyAppMap()));
                                          } else {
                                            var data = selectedServices;

                                            await showModalBottomSheet(
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
                                                  return SelectDate(
                                                    selectedServices: data,
                                                    item: widget.item,
                                                  );
                                                });
                                            resetServices();
                                          }
                                        }
                                      },
                                      child: appButton(bkColor: getButtonColor(), text: AppConstants.bookNow, height: 50.0)),
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

  resetServices() {
    for (var element in selectedServices) {
      element.isSelected = false;
    }
    selectedServices.clear();
    selectedServices.add(vehicles[0]);
    selectedServices.first.isSelected = true;
    if (mounted) {
      setState(() {});
    }
  }

  Color getButtonColor() {
    if (selectedServices.length > 7) {
      return Colours.gray.code;
    } else {
      var list = selectedServices.where((element) => element.id == "6").toList();
      if (selectedServices.length > 1 && list.isNotEmpty) {
        return Colours.gray.code;
      } else {
        return Colours.blue.code;
      }
    }
  }

  void _onSelect(bool? newValue, ServiceTypes type) => setState(() {
        type.isSelected = newValue!;
        if (selectedServices.contains(type)) {
          selectedServices.remove(type);
        } else {
          selectedServices.add(type);
        }
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

class ServiceTypes {
  final String id;
  bool isSelected;
  final String title;
  final String service;
  final String subService;
  final double price;
  final String description;

  ServiceTypes(this.id, this.isSelected, this.title, this.service, this.subService, this.price, this.description);
}

List<ServiceTypes> vehicles = [
  ServiceTypes("1", true, 'Oil Change', 'Castrool Oil', 'Engine Oil', 250.0,
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
  ServiceTypes("2", false, 'Gasonline Delivery', 'Castrool Oil', 'Engine Oil', 270.0,
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
  ServiceTypes("3", false, 'Mobile Car Wash', 'Castrool Oil', 'Engine Oil', 250.0,
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
  ServiceTypes("4", false, 'Auto Repair', 'Castrool Oil', 'Engine Oil', 160.0,
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
  ServiceTypes("5", false, 'Auto Parts', 'Castrool Oil', 'Engine Oil', 250.0,
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
  ServiceTypes("7", false, 'State Inspection', 'Castrool Oil', 'Engine Oil', 160.0,
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
  ServiceTypes("8", false, 'Battery Swap', 'Castrool Oil', 'Engine Oil', 250.0,
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
  ServiceTypes("6", false, 'Road Side Assistance', 'Castrool Oil', 'Engine Oil', 250.0,
      'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected.'),
];
