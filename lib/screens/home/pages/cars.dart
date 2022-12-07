import 'package:app/common/assets.dart';
import 'package:app/common/methods/common.dart';
import 'package:app/model/getCategoryListModel.dart';
import 'package:app/model/getServiceProviderList_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
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
  List<ProviderData> providerData = <ProviderData>[];
  List<ProviderData> searchList = <ProviderData>[];
  List<ProviderData> filteredList = <ProviderData>[];

  List<ServiceCategoryData> categoryDat = [];
  List<ServiceCategoryData> dropDownItem = [];
  List<String> dropDownItemViewString = [];
  String? selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: BlocListener<ServiceProviderBloc, ServiceProviderState>(
          listener: (context, state) {
            if (state.categoryList != null && state.categoryList!.isNotEmpty) {
              dropDownItemViewString = state.categoryList!.map((e) => e.serviceCategory!).toList();
              dropDownItemViewString.insert(0, "No Filter");
              dropDownItem = state.categoryList!;
            }
          },
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
                    Expanded(child: searchBox(controller: searchController, hintText: "service", onSearchChanged: onSearchTextChanged)),
                    horizontalSpacer(),
                    Expanded(
                      child: BlocBuilder<ServiceProviderBloc, ServiceProviderState>(builder: (context, state) {
                        return dropDownItem.isNotEmpty
                            ? AppDropdown(
                                bgColor: Colours.blue.code,
                                items: dropDownItemViewString,
                                selectedItem: selectedValue,
                                height: 44.0,
                                onChange: (val) {
                                  selectedValue = val;
                                  filteredList.clear();
                                  if (val.contains("No Filter")) {
                                    filteredList.clear();
                                  }
                                  for (var element in providerData) {
                                    if (element.serviceCategory != null) {
                                      Map<String, dynamic> myJson = element.serviceCategory!.toJson();
                                      myJson.forEach((key, value) {
                                        if (key.toLowerCase().contains(val.toLowerCase()) && value != null) {
                                          filteredList.add(element);
                                        }
                                      });
                                    }
                                  }
                                  setState(() {});
                                },
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ));
                      }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: CommonMethods.deviceWidth(),
                  height: CommonMethods.deviceHeight(),
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colours.lightGray.code,
                  ),
                  child: BlocBuilder<ServiceProviderBloc, ServiceProviderState>(
                    builder: (context, state) {
                      if (state is CarScreenLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is GetAllServiceProviderFetchSuccessfully || state is BookingFailed || state is BookingSuccessfully) {
                        var data = state.props[0];
                        providerData = data as List<ProviderData>;
                        return MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: searchController.text.isNotEmpty && searchList.isEmpty
                              ? const Center(
                                  child: Text("No data found"),
                                )
                              : providerData.isNotEmpty
                                  ? RefreshIndicator(
                                      onRefresh: () async {
                                        BlocProvider.of<ServiceProviderBloc>(context).add(const AllServiceProviderList());
                                      },
                                      child: ListView.builder(
                                          itemCount: searchController.text.isNotEmpty && searchList.isNotEmpty
                                              ? searchList.length
                                              : filteredList.isNotEmpty
                                                  ? filteredList.length
                                                  : providerData.length,
                                          shrinkWrap: true,
                                          physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                          itemBuilder: (context, index) {
                                            List<String> list = [];
                                            List<Map<String, dynamic>> serviceProviderList = [];
                                            ServiceCategory? serviceData = searchController.text.isNotEmpty || searchList.isNotEmpty
                                                ? searchList[index].serviceCategory
                                                : filteredList.isNotEmpty
                                                    ? filteredList[index].serviceCategory
                                                    : providerData[index].serviceCategory;
                                            if (serviceData!.oilChange != null ||
                                                serviceData.autoParts != null ||
                                                serviceData.autoRepair != null ||
                                                serviceData.carWash != null ||
                                                serviceData.gasoline != null ||
                                                serviceData.roadSideAssistance != null) {
                                              var data = serviceData.toJson();
                                              data.forEach((key, value) {
                                                if (value != null) {
                                                  list.add(key.toString());
                                                  serviceProviderList.add({key: value});
                                                }
                                              });
                                            }

                                            return listItem(
                                                image: searchController.text.isNotEmpty || searchList.isNotEmpty
                                                    ? searchList[index].profile!.userImage!
                                                    : filteredList.isNotEmpty
                                                        ? filteredList[index].profile!.userImage!
                                                        : providerData[index].profile!.userImage!,
                                                serviceType: searchController.text.isNotEmpty || searchList.isNotEmpty
                                                    ? searchList[index].profile!.businessName!
                                                    : filteredList.isNotEmpty
                                                        ? filteredList[index].profile!.businessName!
                                                        : providerData[index].profile!.businessName!,
                                                joinDate: searchController.text.isNotEmpty || searchList.isNotEmpty
                                                    ? searchList[index].profile!.joinDate!
                                                    : filteredList.isNotEmpty
                                                        ? filteredList[index].profile!.joinDate!
                                                        : providerData[index].profile!.joinDate!,
                                                services: List.generate(list.length, (i) {
                                                  return list[i];
                                                }),
                                                lat: searchController.text.isNotEmpty || searchList.isNotEmpty
                                                    ? searchList[index].profile!.addressLat!
                                                    : filteredList.isNotEmpty
                                                        ? filteredList[index].profile!.addressLat!
                                                        : providerData[index].profile!.addressLat!,
                                                long: searchController.text.isNotEmpty || searchList.isNotEmpty
                                                    ? searchList[index].profile!.addressLong!
                                                    : filteredList.isNotEmpty
                                                        ? filteredList[index].profile!.addressLong!
                                                        : providerData[index].profile!.addressLong!,
                                                rating: searchController.text.isNotEmpty || searchList.isNotEmpty && searchList[index].profile!.rating != null
                                                    ? double.parse(searchList[index].profile!.rating ?? "4")
                                                    : filteredList.isNotEmpty && filteredList[index].profile!.rating != null
                                                        ? double.parse(filteredList[index].profile!.rating!)
                                                        : providerData[index].profile!.rating != null
                                                            ? double.parse(providerData[index].profile!.rating!)
                                                            : 4.0,
                                                serviceProviderList: serviceProviderList,
                                                userId: searchController.text.isNotEmpty || searchList.isNotEmpty
                                                    ? searchList[index].profile!.userId
                                                    : filteredList.isNotEmpty
                                                        ? filteredList[index].profile!.userId
                                                        : providerData[index].profile!.userId);
                                          }),
                                    )
                                  : const Center(child: Text("No data found")),
                        );
                      }
                      return const Center(
                        child: Text("No data found"),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listItem({
    required String image,
    required String serviceType,
    required String joinDate,
    required List<String> services,
    double rating = 3,
    double? lat,
    double? long,
    List<Map<String, dynamic>>? serviceProviderList,
    required int userId,
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
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: image,
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
                    Text(
                      serviceType,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      style: AppStyles.blackSemiBold,
                    ),
                    Text(
                      "Joined $joinDate",
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
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 4.0, right: 4.0),
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
                    itemSize: 18.0,
                  ),
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
                      Navigator.of(context, rootNavigator: true).push(
                        CupertinoPageRoute(
                          builder: (context) => MyAppMap(
                            showPickUp: false,
                            showMarker: true,
                            latLng: LatLng(lat!, long!),
                          ),
                        ),
                      );
                    },
                    child: rowButton(
                      bkColor: Colours.lightWhite.code,
                      textColor: Colours.blue.code,
                      text: AppConstants.location,
                      paddingHorizontal: 8.0,
                      paddingVertical: 7.0,
                    ),
                  ),
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
                          "lat": lat,
                          "serviceProviderList": serviceProviderList,
                          "long": long,
                          "userId": userId
                        };
                        Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(builder: (context) => ServiceDetails(item: item)));
                      },
                      child: rowButton(bkColor: Colours.blue.code, text: AppConstants.bookNow, paddingHorizontal: 8.0, paddingVertical: 7.0)),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  getDefaultRefreshData() {
    BlocProvider.of<ServiceProviderBloc>(context).add(const AllServiceProviderList());
  }

  Future<String> getAddressFromLatLong(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    var address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return address;
  }

  onSearchTextChanged(String text) async {
    searchList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    if (filteredList.isNotEmpty) {
      for (var element in filteredList) {
        if (element.profile!.businessName!.toLowerCase().contains(text.toLowerCase())) {
          searchList.add(element);
        }
      }
    } else {
      for (var element in providerData) {
        if (element.profile!.businessName!.toLowerCase().contains(text.toLowerCase())) {
          searchList.add(element);
        }
      }
    }

    setState(() {});
  }
}
