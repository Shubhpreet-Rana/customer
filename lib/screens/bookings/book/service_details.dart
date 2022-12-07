import 'package:app/model/getServiceProviderList_model.dart';
import 'package:app/screens/bookings/book/calender_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../common/methods/common.dart';
import '../../../common/styles/styles.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/headers.dart';
import '../../maps/maps_page.dart';

class ServiceDetails extends StatefulWidget {
  final Map<String, dynamic> item;

  const ServiceDetails({Key? key, required this.item}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  List<ServiceTypes> selectedServices = [];
  List<ServiceTypes>? serviceType = [];
  String? address;
  List<ServiceCategory>? serviceCategory;
  LatLng? latLng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.item['serviceProviderList'].length > 0) {
      var data = widget.item['serviceProviderList'];
      data.forEach((element) {
        ServiceTypes? serviceTypes;
        for (final mapEntry in element.entries) {
          final key = mapEntry.key;
          final value = mapEntry.value;
          serviceTypes = ServiceTypes(value['cat_id'].toString(), false, key ?? "", "service", "subService", value['price'].toString(), value['description'], value['gst_rate'].toString());
        }
        serviceType!.add(serviceTypes!);
      });
    }

    getAddressFromLatLong(widget.item['lat']!, widget.item['long']);
  }

  Future<void> getAddressFromLatLong(double latitude, double longitude) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placeMarks[0];
      String data = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      address = data;
      setState(() {});
    } on PlatformException catch (e) {
      debugPrint(e.message);
      debugPrint(e.details);
      debugPrint(e.code);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
    }
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header(),
                      verticalSpacer(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 20.0,
                        ),
                        child: Text(
                          AppConstants.serviceCategories,
                          style: AppStyles.blackSemiBold,
                        ),
                      ),
                      verticalSpacer(height: 10.0),
                      SingleChildScrollView(
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
                                  itemCount: serviceType!.length,
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
                                                value: serviceType![i].isSelected,
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                onChanged: (val) {
                                                  _onSelect(val, serviceType![i]);
                                                }),
                                          ),
                                          horizontalSpacer(
                                            width: 10.0,
                                          ),
                                          Text(
                                            serviceType![i].title,
                                            style: AppStyles.blackSemiBold,
                                          ),
                                        ],
                                      ),
                                      children: <Widget>[
                                        _buildExpandableContent(serviceType![i]),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              verticalSpacer(),
                              appButton(
                                bkColor: getButtonColor(),
                                onTapped: () async {
                                  await _bookNow();
                                },
                                text: AppConstants.bookNow,
                                height: 50.0,
                              ),
                              verticalSpacer(height: 100.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  resetServices() {
    for (var element in selectedServices) {
      element.isSelected = false;
    }
    selectedServices.clear();
    if (mounted) {
      setState(() {});
    }
  }

  Color getButtonColor() {
    if (selectedServices.isNotEmpty) {
      return Colours.blue.code;
    } else {
      return Colours.gray.code;
    }
  }

  _onSelect(bool? newValue, ServiceTypes type) {
    if (selectedServices.isNotEmpty) {
      // ignore: curly_braces_in_flow_control_structures
      if (selectedServices.contains(type)) {
        type.isSelected = newValue!;
        selectedServices.remove(type);
      } else {
        var data = selectedServices.where((element) => element.id == "6").toList();
        if (data.isNotEmpty) {
          CommonMethods().showToast(
            context: context,
            message: "You cannot select another service category with road side assistance", /*   isSuccess: false*/
          );
        } else {
          if (type.id == "6") {
            CommonMethods().showToast(
              context: context,
              message: "You cannot select road side assistance", /*isSuccess: false*/
            );
          } else {
            type.isSelected = newValue!;
            selectedServices.add(type);
          }
        }
      }
    } else {
      type.isSelected = newValue!;
      selectedServices.add(type);
    }
    if (mounted) setState(() {});
  }

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
                  vehicle.title,
                  style: AppStyles.blackBold,
                ),
                /* Text(
                  "- " + vehicle.subService,
                  style: AppStyles.lightText,
                ),*/
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
                    CachedNetworkImage(
                      imageUrl: widget.item['image'],
                      fit: BoxFit.cover,
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
                  widget.item['serviceType'] ?? AppConstants.serviceType,
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
                   "Joined ${widget.item['joinDate']}",
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
                        address ?? "China town, Down street, \nCalifornia",
                        textAlign: TextAlign.start,
                        softWrap: true,
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

  Future<void> _bookNow() async {
    if (selectedServices.isNotEmpty) {
      List<ServiceTypes> roadSideAssistanceExist = selectedServices.where((element) => element.id == "6").toList();
      if (roadSideAssistanceExist.isNotEmpty) {
        Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(
            builder: (context) => MyAppMap(
                  serviceTypes: roadSideAssistanceExist[0],
                  callback: (LatLng latLng) async {
                    ServiceTypes roadSideAssistanceType = roadSideAssistanceExist[0];
                    roadSideAssistanceType.lat = latLng.latitude;
                    roadSideAssistanceType.long = latLng.latitude;
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
                            selectedServices: [roadSideAssistanceType],
                            item: widget.item,
                          );
                        });
                  },
                )));
      } else {
        List<ServiceTypes> serviceCategories = selectedServices;
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
                selectedServices: serviceCategories,
                item: widget.item,
              );
            });
      }
      resetServices();
    }
  }
}

class ServiceTypes {
  final String id;
  bool isSelected;
  final String title;
  final String service;
  final String subService;
  final String price;
  final String description;
  String? gstRate;
  double? lat;
  double? long;

  ServiceTypes(this.id, this.isSelected, this.title, this.service, this.subService, this.price, this.description, this.gstRate, {this.lat, this.long});
}
