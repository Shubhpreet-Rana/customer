import 'dart:io';

import 'package:app/bloc/home/add_car/add_car_bloc.dart';
import 'package:app/common/location_util.dart';
import 'package:app/model/all_vehicle_model.dart';
import 'package:app/model/my_marketplace_vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/styles/styles.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/drop_down.dart';
import '../../common/ui/edit_text.dart';
import '../../common/ui/headers.dart';

class SellCar extends StatefulWidget {
  final bool fromEdit;
  final AllVehicleData? myVehicleMarketPlace;

  SellCar({Key? key, this.fromEdit = false, this.myVehicleMarketPlace}) : super(key: key);

  @override
  State<SellCar> createState() => _SellCarState();
}

class _SellCarState extends State<SellCar> {
  TextEditingController brandNameController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController manufacturingController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String selectedColor = "Black";
  String mileage = "";
  String image1 = "";
  String image2 = '';
  String image3 = "";
  double locationLat = 0.0;
  double locationLang = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    print(widget.myVehicleMarketPlace);
    getVehicleData();
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime.now().subtract(const Duration(days: 7305)), lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: BlocListener<SellCarBloc, AddCarToSellState>(
          listener: (context, state) {
            if (state is AddCarSuccessfully) {
              Navigator.of(context).pop();
              CommonMethods().showTopFlash(context: context, message: "Car added successfully");
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(bottom: false, child: AppHeaders().extendedHeader(text: AppConstants.vehicle, context: context)),
              verticalSpacer(
                height: 10.0,
              ),
              Expanded(
                  child: Container(
                width: CommonMethods.deviceWidth(),
                height: CommonMethods.deviceHeight(),
                padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 5.0, top: 40.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(33),
                    topRight: Radius.circular(33),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpacer(height: 10.0),
                      headingText(text: AppConstants.brandText),
                      verticalSpacer(height: 10.0),
                      MyEditText(widget.myVehicleMarketPlace!.brandName!.isNotEmpty ? widget.myVehicleMarketPlace!.brandName! : AppConstants.brandText, false, TextInputType.text,
                          TextCapitalization.none, 10.0, brandNameController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      headingText(text: AppConstants.modelText),
                      verticalSpacer(height: 10.0),
                      MyEditText(widget.myVehicleMarketPlace!.modelName!.isNotEmpty ? widget.myVehicleMarketPlace!.brandName! : AppConstants.modelText, false, TextInputType.text,
                          TextCapitalization.none, 10.0, modelController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      headingText(text: AppConstants.engineText),
                      verticalSpacer(height: 10.0),
                      MyEditText(widget.myVehicleMarketPlace!.capacity != null ? widget.myVehicleMarketPlace!.capacity!.toString() : AppConstants.engineText, false, TextInputType.text,
                          TextCapitalization.none, 10.0, engineController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      headingText(text: AppConstants.colorText),
                      verticalSpacer(height: 10.0),
                      AppDropdown(
                        bgColor: Colours.blue.code,
                        items: AppConstants.colorItems,
                        selectedItem: AppConstants.colorItems[0],
                        onChange: (String? val) {
                          selectedColor = val!;
                          setState(() {});
                        },
                      ),
                      verticalSpacer(),
                      headingText(text: AppConstants.mileageText),
                      verticalSpacer(height: 10.0),
                      AppDropdown(
                          bgColor: Colours.blue.code,
                          items: AppConstants.mileageItems,
                          selectedItem: AppConstants.mileageItems[0],
                          onChange: (value) {
                            mileage = value;
                            setState(() {});
                          }),
                      verticalSpacer(),
                      headingText(text: AppConstants.priceText),
                      verticalSpacer(height: 10.0),
                      MyEditText(widget.myVehicleMarketPlace!.price!.isNotEmpty ? widget.myVehicleMarketPlace!.price! : r"$", false, TextInputType.number, TextCapitalization.none, 10.0,
                          priceController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      headingText(text: AppConstants.dateText),
                      verticalSpacer(height: 10.0),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          _selectDate(context);
                        },
                        child: MyEditText(
                          AppConstants.dateText1,
                          false,
                          TextInputType.text,
                          TextCapitalization.none,
                          10.0,
                          dateController,
                          Colours.hintColor.code,
                          false,
                          isSuffix: true,
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: Colours.blue.code,
                          ),
                        ),
                      ),
                      verticalSpacer(),
                      headingText(text: AppConstants.manufacturingYearText),
                      verticalSpacer(height: 10.0),
                      MyEditText(widget.myVehicleMarketPlace!.manufacturingYear!.isNotEmpty ? widget.myVehicleMarketPlace!.manufacturingYear! : AppConstants.manufacturingYearText, false,
                          TextInputType.number, TextCapitalization.none, 10.0, manufacturingController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      headingText(text: AppConstants.descriptionText),
                      verticalSpacer(height: 10.0),
                      MyEditText(
                        widget.myVehicleMarketPlace!.description!.isNotEmpty ? widget.myVehicleMarketPlace!.description! : AppConstants.descriptionText,
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
                      GestureDetector(
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
                              print(result);

                              if (mounted && result != null) {
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
                        child: MyEditText(
                          widget.myVehicleMarketPlace!.address!.isNotEmpty ? widget.myVehicleMarketPlace!.address! : AppConstants.address,
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
                        ),
                      ),
                      verticalSpacer(),
                      headingText(text: AppConstants.imageText),
                      verticalSpacer(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocListener<SellCarBloc, AddCarToSellState>(
                            listener: (context, state) {
                              if (state is ImageSelected1Successfully) {
                                if (state.imagePath!.isNotEmpty) {
                                  image1 = state.imagePath!;
                                  if (mounted) {
                                    setState(() {});
                                  }
                                }
                              }
                            },
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                BlocProvider.of<SellCarBloc>(context).add(Select1Image(context));
                              },
                              child: image1 != ""
                                  ? grayContainer(
                                      text: AppConstants.imageText1,
                                      icon: Icon(
                                        Icons.add,
                                        color: Colours.blue.code,
                                      ),
                                      paddingHorizontal: 15.0,
                                      paddingVertical: 15.0,
                                      imagePath: image1)
                                  : grayContainer(
                                      text: AppConstants.imageText1,
                                      icon: Icon(
                                        Icons.add,
                                        color: Colours.blue.code,
                                      ),
                                      paddingHorizontal: 15.0,
                                      paddingVertical: 15.0,
                                    ),
                            ),
                          ),
                          BlocListener<SellCarBloc, AddCarToSellState>(
                            listener: (context, state) {
                              if (state is ImageSelected2Successfully) {
                                if (state.imagePath!.isNotEmpty) {
                                  image2 = state.imagePath!;
                                  if (mounted) {
                                    setState(() {});
                                  }
                                }
                              }
                            },
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                BlocProvider.of<SellCarBloc>(context).add(Select2Image(context));
                              },
                              child: image2 != ""
                                  ? grayContainer(
                                      text: AppConstants.imageText1,
                                      icon: Icon(
                                        Icons.add,
                                        color: Colours.blue.code,
                                      ),
                                      paddingHorizontal: 15.0,
                                      paddingVertical: 15.0,
                                      imagePath: image2)
                                  : grayContainer(
                                      text: AppConstants.imageText1,
                                      icon: Icon(
                                        Icons.add,
                                        color: Colours.blue.code,
                                      ),
                                      paddingHorizontal: 15.0,
                                      paddingVertical: 15.0,
                                    ),
                            ),
                          ),
                          BlocListener<SellCarBloc, AddCarToSellState>(
                            listener: (context, state) {
                              if (state is ImageSelected3Successfully) {
                                if (state.imagePath!.isNotEmpty) {
                                  image3 = state.imagePath!;
                                  if (mounted) {
                                    setState(() {});
                                  }
                                }
                              }
                            },
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                BlocProvider.of<SellCarBloc>(context).add(Select3Image(context));
                              },
                              child: image3 != ""
                                  ? grayContainer(
                                      text: AppConstants.imageText1,
                                      icon: Icon(
                                        Icons.add,
                                        color: Colours.blue.code,
                                      ),
                                      paddingHorizontal: 15.0,
                                      paddingVertical: 15.0,
                                      imagePath: image3)
                                  : grayContainer(
                                      text: AppConstants.imageText1,
                                      icon: Icon(
                                        Icons.add,
                                        color: Colours.blue.code,
                                      ),
                                      paddingHorizontal: 15.0,
                                      paddingVertical: 15.0,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpacer(),
                      BlocBuilder<SellCarBloc, AddCarToSellState>(builder: (context, state) {
                        if (state is Loading) {
                          return SizedBox(
                            width: CommonMethods.deviceWidth(),
                            height: 55,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return BlocBuilder<SellCarBloc, AddCarToSellState>(builder: (context, state) {
                          return state is Loading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    if (!widget.fromEdit) {
                                      validateData();
                                    }
                                    if (widget.fromEdit) {
                                      updateVehicleDetail();
                                    }
                                    //Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => const HomeTabs()));
                                  },
                                  child: appButton(bkColor: Colours.blue.code, text: widget.fromEdit ? AppConstants.update : AppConstants.addCar));
                        });
                      }),
                      verticalSpacer(height: 120),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  validateData() {
    if (brandNameController.text.isEmpty) {
      CommonMethods().showTopFlash(context: context, message: "Brand name is required");
    } else if (modelController.text.isEmpty) {
      CommonMethods().showTopFlash(context: context, message: "Model is required");
    } else if (engineController.text.isEmpty) {
      CommonMethods().showTopFlash(context: context, message: "Capacity is required");
    } else if (selectedColor.isEmpty) {
      CommonMethods().showTopFlash(context: context, message: "Color is required");
    } else if (selectedColor.isEmpty) {
      CommonMethods().showTopFlash(context: context, message: "Color is required");
    } else if (descriptionController.text.isEmpty) {
      CommonMethods().showTopFlash(context: context, message: "Description is required");
    } else if (mileage.isEmpty) {
      CommonMethods().showTopFlash(context: context, message: "Mileage is required");
    } else if (manufacturingController.text.isEmpty) {
      CommonMethods().showTopFlash(context: context, message: "Manufacturing year is required");
    } else if (dateController.text.isEmpty) {
      CommonMethods().showTopFlash(context: context, message: "Date is required");
    } else if (priceController.text.isEmpty) {
      CommonMethods().showTopFlash(context: context, message: "Price is required");
    } else if (addressController.text.isEmpty) {
      CommonMethods().showTopFlash(context: context, message: "Address is required");
    } else {
      BlocProvider.of<SellCarBloc>(context).add(AddCarToSell(
          brand_name: brandNameController.text,
          model_name: modelController.text,
          capacity: engineController.text,
          color: selectedColor,
          description: descriptionController.text,
          mileage: mileage,
          manufacturing_year: manufacturingController.text,
          address: addressController.text,
          price: priceController.text,
          car_image_1: image1,
          car_image_2: image2.isNotEmpty ? image2 : "",
          car_image_3: image3.isNotEmpty ? image3 : "",
          address_lat: locationLat,
          address_long: locationLang));
    }
  }

  void updateVehicleDetail() {
 BlocProvider.of<SellCarBloc>(context).add(UpdateCarToSell(
   id: widget.myVehicleMarketPlace!.id
 ));

  }

  void getVehicleData() {
    if (widget.fromEdit) {
      if (widget.myVehicleMarketPlace!.color!.isNotEmpty) {
        selectedColor = widget.myVehicleMarketPlace!.color!;
        mileage = widget.myVehicleMarketPlace!.mileage!;
        if (mounted) {
          setState(() {});
        }
      }
    }
  }
}
