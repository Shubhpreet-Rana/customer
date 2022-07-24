import 'package:app/common/assets.dart';
import 'package:app/common/methods/common.dart';
import 'package:app/model/getServiceProviderList_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../bloc/serviceProvider/service_provider_bloc.dart';
import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../common/styles/styles.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/drop_down.dart';
import '../../../common/ui/headers.dart';
import '../../bookings/book/service_details.dart';
import '../../maps/maps_page.dart';

class CarTab extends StatefulWidget {
  const CarTab({Key? key}) : super(key: key);

  @override
  State<CarTab> createState() => _CarTabState();
}

class _CarTabState extends State<CarTab> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ServiceProviderBloc>(context)
        .add(AllServiceProviderList("", "", "", {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
              bottom: false,
              child: AppHeaders().collapsedHeader(
                  text: AppConstants.sProviderText,
                  context: context,
                  backNavigation: false,
                  onFilterClick: () {
                    CommonMethods().openFilters(context);
                  },
                  onNotificationClick: () {
                    CommonMethods().openNotifications(context);
                  })),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: searchBox(
                        controller: searchController, hintText: "service")),
                horizontalSpacer(),
                Expanded(
                  child: AppDropdown(
                    bgColor: Colours.blue.code,
                    items: AppConstants.serviceItems,
                    selectedItem: AppConstants.serviceItems[0],
                    height: 44.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
                  width: CommonMethods.deviceWidth(),
                  height: CommonMethods.deviceHeight(),
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colours.lightGray.code,
                  ),
                  child: BlocListener<ServiceProviderBloc,
                          ServiceProviderState>(
                      listener: (context, state) {},
                      child: BlocBuilder<ServiceProviderBloc,
                          ServiceProviderState>(builder: (context, state) {
                        if (state is CarScreenLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is GetAllServiceProviderFetchSuccessfully) {
                          var data = state.props[0];
                          List<ProviderData> providerData =
                              data as List<ProviderData>;
                          return MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: providerData.isNotEmpty
                                ? ListView.builder(
                                    itemCount: providerData.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      List<String> list = [];
                                      List<Map<String, dynamic>>
                                          serviceProviderList = [];
                                      var serviceData =
                                          providerData[index].serviceCategory;
                                      var data = serviceData!.toJson();
                                      data.forEach((key, value) {
                                        if (value != null) {
                                          list.add(key.toString());
                                          serviceProviderList.add({key: value});
                                        }
                                      });

                                      return listItem(
                                          image: providerData[index]
                                              .profile!
                                              .userImage!,
                                          serviceType: providerData[index]
                                              .profile!
                                              .businessName!,
                                          joinDate: providerData[index]
                                              .profile!
                                              .joinDate!,
                                          services:
                                              List.generate(list.length, (i) {
                                            return list[i];
                                          }),
                                          lat: providerData[index]
                                              .profile!
                                              .addressLat!,
                                          long: providerData[index]
                                              .profile!
                                              .addressLong!,
                                          rating: providerData[index]
                                                      .profile!
                                                      .rating !=
                                                  null
                                              ? double.parse(providerData[index]
                                                  .profile!
                                                  .rating!)
                                              : 4.0,
                                          serviceProviderList:
                                              serviceProviderList);
                                    })
                                : const Text("No data found"),
                          );
                        }
                        return const Center(
                          child: Text("No data found"),
                        );
                      }))))
        ],
      )),
    );
  }

  Widget listItem({
    required String image,
    required String serviceType,
    required String joinDate,
    required List<String> services,
    double rating = 4,
    double? lat,
    double? long,
    List<Map<String, dynamic>>? serviceProviderList,
  }) {

    return Column(
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
                      imageUrl: image,
                      fit: BoxFit.fill,
                    )),
              ),
              horizontalSpacer(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      serviceType,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: AppStyles.blackSemiBold,
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
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 4.0, right: 4.0),
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
                  /* RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 18.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Color(0xFFF1C21C),
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),*/
                  Text(rating.toString())
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.of(context, rootNavigator: false).push(
                            CupertinoPageRoute(
                                builder: (context) => MyAppMap(
                                    showPickUp: false,
                                    showMarker: true,
                                    latLng: LatLng(lat!, long!))));
                      },
                      child: rowButton(
                          bkColor: Colours.lightWhite.code,
                          textColor: Colours.blue.code,
                          text: AppConstants.location,
                          paddingHorizontal: 8.0,
                          paddingVertical: 7.0)),
                  horizontalSpacer(),
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Map<String, dynamic> item = {
                          "image": image,
                          "serviceType": serviceType,
                          "joinDate": joinDate,
                          "services": services,
                          "rating": rating,
                          "lat":lat,
                          "serviceProviderList": serviceProviderList,
                          "long":long
                        };
                        Navigator.of(context, rootNavigator: false).push(
                            CupertinoPageRoute(
                                builder: (context) =>
                                    ServiceDetails(item: item)));
                      },
                      child: rowButton(
                          bkColor: Colours.blue.code,
                          text: AppConstants.bookNow,
                          paddingHorizontal: 8.0,
                          paddingVertical: 7.0)),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  getDefaultRefreshData() {
    BlocProvider.of<ServiceProviderBloc>(context)
        .add(AllServiceProviderList("", "", "", {}));
  }

  Future<String> getAddressFromLatLong(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    var address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return address;
  }
}
