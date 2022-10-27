import 'package:app/bloc/serviceProvider/service_provider_bloc.dart';
import 'package:app/common/location_util.dart';
import 'package:app/model/getCategoryListModel.dart';
import 'package:app/model/getServiceProviderList_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:place_picker/place_picker.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/styles/styles.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/edit_text.dart';
import '../../common/ui/headers.dart';

class ApplyFilters extends StatefulWidget {
  const ApplyFilters({Key? key}) : super(key: key);

  @override
  State<ApplyFilters> createState() => _ApplyFiltersState();
}

class _ApplyFiltersState extends State<ApplyFilters> {
  int _radioValue1 = 1000; // for non selection of radio button
  TextEditingController addressController = TextEditingController();
  List<ServiceCategory> serviceCategoryList = [];
  ServiceCategoryData? categoryData;
  String selectedCategoryId = "";
  int currentRatingIndex = 4;
  double locationLat = 0.0;
  double locationLang = 0.0;

  void _handleRadioValueChange1(int value, ServiceCategoryData data) {
    setState(() {
      _radioValue1 = value;
      categoryData = data;
      selectedCategoryId = categoryData!.id.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ServiceProviderBloc>(context).add(GetCategoryList());
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
                child: AppHeaders().extendedHeader(
                    onTapped: () {
                      BlocProvider.of<ServiceProviderBloc>(context).add(AllServiceProviderList("", "", "", const {}));
                      Navigator.of(context).pop();
                    },
                    text: AppConstants.filters,
                    context: context)),
            verticalSpacer(
              height: 40.0,
            ),
            Expanded(
              child: Container(
                width: CommonMethods.deviceWidth(),
                height: CommonMethods.deviceHeight(),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(33),
                    topRight: Radius.circular(33),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: BlocListener<ServiceProviderBloc, ServiceProviderState>(
                  listener: (context, state) {},
                  child: BlocBuilder<ServiceProviderBloc, ServiceProviderState>(
                    builder: (context, state) {
                      if (state is CategoryListLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is CategoryListFetchSuccessfully) {
                        var data = state.props[0];
                        List<ServiceCategoryData> serviceCategory = data as List<ServiceCategoryData>;
                        if (serviceCategory.isNotEmpty) {
                          categoryData = serviceCategory[0];
                        }
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (serviceCategory.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.only(left: 50.0, right: 30.0, bottom: 5.0, top: 50.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppConstants.category,
                                        style: AppStyles.blackSemiBold,
                                      ),
                                      verticalSpacer(height: 10.0),
                                      getRadioButtons(serviceCategory),
                                    ],
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: SizedBox(
                                    height: 58.0,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: List.generate(5, (index) {
                                          return GestureDetector(
                                              onTap: () {
                                                currentRatingIndex = index;
                                                setState(() {});
                                              },
                                              child: ratingBar(currentRatingIndex: currentRatingIndex, index: index));
                                        }))),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(left: 50.0, right: 30.0, bottom: 5.0, top: 20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppConstants.location1,
                                        style: AppStyles.blackSemiBold,
                                      ),
                                      verticalSpacer(height: 10.0),
                                      /*       MyEditText(
                                  AppConstants.location1,
                                  false,
                                  TextInputType.streetAddress,
                                  TextCapitalization.none,
                                  10.0,
                                  addressController,
                                  Colours.hintColor.code,
                                  true,
                                  isSuffix: true,
                                  suffixIcon: Icon(
                                    Icons.location_pin,
                                    color: Colours.blue.code,
                                  ),
                                ),*/
                                      MyEditText(
                                        AppConstants.location1,
                                        false,
                                        TextInputType.streetAddress,
                                        TextCapitalization.none,
                                        10.0,
                                        addressController,
                                        Colours.hintColor.code,
                                        true,
                                        isSuffix: true,
                                        suffixIcon: GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap: () async {
                                            try {
                                              Position? position = await LocationUtil.getLocation();
                                              if (position != null) {
                                                LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => PlacePicker(
                                                          "AIzaSyBPFuOfeRqXLrspLP3_p7MmgL2OaLzg9nk",
                                                        )));

                                                // Handle the result in your way

                                                if (mounted) {
                                                  setState(() {
                                                    locationLat = result.latLng!.latitude;
                                                    locationLang = result.latLng!.longitude;
                                                    addressController.text = result.formattedAddress!;
                                                  });
                                                }
                                              }
                                            } catch (e) {
                                              throw e.toString();
                                            }
                                          },
                                          child: Icon(
                                            Icons.location_pin,
                                            color: Colours.blue.code,
                                          ),
                                        ),
                                      ),
                                      verticalSpacer(),
                                      appButton(
                                          bkColor: Colours.blue.code,
                                          text: AppConstants.applyFilters,
                                          onTapped: () {
                                            BlocProvider.of<ServiceProviderBloc>(context).add(AllServiceProviderList(
                                                "", selectedCategoryId, "${currentRatingIndex + 1}", addressController.text.isNotEmpty ? {"lat": locationLat, "long": locationLang} : {}));
                                            Navigator.of(context).pop();
                                          })
                                    ],
                                  ))
                            ],
                          ),
                        );
                      }
                      return const Center(
                        child: Text("No Category List"),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getRadioButtons(List<ServiceCategoryData> serviceCategory) {
    return ListView.builder(
        itemCount: serviceCategory.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: Radio(
                  value: index,
                  groupValue: _radioValue1,
                  onChanged: (int? value) {
                    if (value != null) {
                      ServiceCategoryData data = serviceCategory[index];
                      setState(() {
                        _handleRadioValueChange1(value, data);
                      });
                    }
                  },
                ),
              ),
              horizontalSpacer(width: 10.0),
              Text(serviceCategory[index].serviceCategory.toString()),
            ],
          );
        });
  }
}
