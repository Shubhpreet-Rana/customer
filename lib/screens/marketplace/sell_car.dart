import 'dart:io';

import 'package:app/bloc/home/add_car/add_car_bloc.dart';
import 'package:app/bloc/home/view_cars/view_car_bloc.dart';
import 'package:app/common/location_util.dart';
import 'package:app/model/all_vehicle_model.dart';
import 'package:app/model/my_marketplace_vehicle.dart';
import 'package:app/permission_handler.dart';
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
  final MyVehicleMarketPlace ? myVehicle;

  SellCar({Key? key, this.fromEdit = false, this.myVehicleMarketPlace,this.myVehicle}) : super(key: key);

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
  String updatedImage1 = "";
  String updatedImage2 = "";
  String updatedImage3 = "";
  double locationLat = 0.0;
  double locationLang = 0.0;

  @override
  void initState() {
    // TODO: implement initState
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
              CommonMethods().showToast(context: context, message: "Car added successfully"/*, isSuccess: true, title: "Success"*/);
            }
            if (state is UpdateCarSuccessFully) {
              BlocProvider.of<ViewCarBloc>(context).add(GetMyMarketVehicle());
              Navigator.of(context).pop();
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
                      MyEditText(AppConstants.brandText, false, TextInputType.text, TextCapitalization.none, 10.0, brandNameController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      headingText(text: AppConstants.modelText),
                      verticalSpacer(height: 10.0),
                      MyEditText(AppConstants.modelText, false, TextInputType.text, TextCapitalization.none, 10.0, modelController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      headingText(text: AppConstants.engineText),
                      verticalSpacer(height: 10.0),
                      MyEditText(AppConstants.engineText, false, TextInputType.text, TextCapitalization.none, 10.0, engineController, Colours.hintColor.code, true),
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
                      MyEditText(r"$", false, TextInputType.number, TextCapitalization.none, 10.0, priceController, Colours.hintColor.code, true),
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
                      MyEditText(AppConstants.manufacturingYearText, false, TextInputType.number, TextCapitalization.none, 10.0, manufacturingController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      headingText(text: AppConstants.descriptionText),
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
                          AppConstants.address,
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
                          Expanded(
                            child: BlocListener<SellCarBloc, AddCarToSellState>(
                              listener: (context, state) {
                                if (state is ImageSelected1Successfully) {
                                  if (state.imagePath!.isNotEmpty) {
                                    if (!widget.fromEdit) {
                                      image1 = state.imagePath!;
                                    } else {
                                      updatedImage1 = "";
                                      image1 = state.imagePath!;
                                    }
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  }
                                }
                              },
                              child: updatedImage1 != ""
                                  ? GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () async {
                                        BlocProvider.of<SellCarBloc>(context).add(Select1Image(context));
                                      },
                                      child: grayContainer(
                                          fromEdit: widget.fromEdit,
                                          text: AppConstants.imageText1,
                                          icon: Icon(
                                            Icons.add,
                                            color: Colours.blue.code,
                                          ),
                                          paddingHorizontal: 15.0,
                                          paddingVertical: 15.0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: Image.network(
                                              updatedImage1,
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    )
                                  : GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () async {
                                        BlocProvider.of<SellCarBloc>(context).add(Select1Image(context));
                                      },
                                      child: image1 != ""
                                          ? SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: grayContainer(
                                                  fromEdit: widget.fromEdit,
                                                  text: AppConstants.imageText1,
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colours.blue.code,
                                                  ),
                                                  paddingHorizontal: 15.0,
                                                  paddingVertical: 15.0,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    child: Image.file(
                                                      File(image1),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                            )
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
                          ),
                          horizontalSpacer(width: 5.0),
                          Expanded(
                            child: BlocListener<SellCarBloc, AddCarToSellState>(
                              listener: (context, state) {
                                if (state is ImageSelected2Successfully) {
                                  if (state.imagePath!.isNotEmpty) {
                                    if (!widget.fromEdit) {
                                      image2 = state.imagePath!;
                                    } else {
                                      updatedImage2 = "";
                                      image2 = state.imagePath!;
                                    }
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  }
                                }
                              },
                              child: updatedImage2 != ""
                                  ? GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () async {
                                        BlocProvider.of<SellCarBloc>(context).add(Select2Image(context));
                                      },
                                      child: grayContainer(
                                          fromEdit: widget.fromEdit,
                                          text: AppConstants.imageText1,
                                          icon: Icon(
                                            Icons.add,
                                            color: Colours.blue.code,
                                          ),
                                          paddingHorizontal: 15.0,
                                          paddingVertical: 15.0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: Image.network(
                                              updatedImage2,
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    )
                                  : GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () async {
                                        BlocProvider.of<SellCarBloc>(context).add(Select2Image(context));
                                      },
                                      child: image2 != ""
                                          ? SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: grayContainer(
                                                  fromEdit: widget.fromEdit,
                                                  text: AppConstants.imageText1,
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colours.blue.code,
                                                  ),
                                                  paddingHorizontal: 15.0,
                                                  paddingVertical: 15.0,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    child: Image.file(
                                                      File(image2),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                            )
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
                          ),
                          horizontalSpacer(width: 5.0),
                          Expanded(
                            child: BlocListener<SellCarBloc, AddCarToSellState>(
                              listener: (context, state) {
                                if (state is ImageSelected3Successfully) {
                                  if (state.imagePath!.isNotEmpty) {
                                    if (!widget.fromEdit) {
                                      image3 = state.imagePath!;
                                    } else {
                                      updatedImage3 = "";
                                      image3 = state.imagePath!;
                                    }
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  }
                                }
                              },
                              child: updatedImage3 != ""
                                  ? GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () async {
                                        BlocProvider.of<SellCarBloc>(context).add(Select3Image(context));
                                      },
                                      child: grayContainer(
                                          fromEdit: widget.fromEdit,
                                          text: AppConstants.imageText1,
                                          icon: Icon(
                                            Icons.add,
                                            color: Colours.blue.code,
                                          ),
                                          paddingHorizontal: 15.0,
                                          paddingVertical: 15.0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: Image.network(
                                              updatedImage3,
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    )
                                  : GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () async {
                                        BlocProvider.of<SellCarBloc>(context).add(Select3Image(context));
                                      },
                                      child: image3 != ""
                                          ? SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: grayContainer(
                                                  fromEdit: widget.fromEdit,
                                                  text: AppConstants.imageText1,
                                                  icon: Icon(
                                                    Icons.add,
                                                    color: Colours.blue.code,
                                                  ),
                                                  paddingHorizontal: 15.0,
                                                  paddingVertical: 15.0,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    child: Image.file(
                                                      File(image3),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                            )
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
                          return state is Loading || state is UpdateLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    if (!widget.fromEdit) {
                                      validateData(context);
                                    }
                                    if (widget.fromEdit) {
                                      updateVehicleDetail();
                                    }
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

  validateData(BuildContext context) {
    if (brandNameController.text.isEmpty) {
      return CommonMethods().showToast(context: context, message: "Brand name is required");
    } else if (modelController.text.isEmpty) {
      return  CommonMethods().showToast(context:context, message: "Model is required");
    } else if (engineController.text.isEmpty) {
      return CommonMethods().showToast(context:context, message: "Capacity is required");
    } else if (selectedColor.isEmpty) {
      return  CommonMethods().showToast(context:context, message: "Color is required");
    } else if (selectedColor.isEmpty) {
      return  CommonMethods().showToast(context:context, message: "Color is required");
    } else if (descriptionController.text.isEmpty) {
      CommonMethods().showToast(context:context, message: "Description is required");
    } else if (mileage.isEmpty) {
      return  CommonMethods().showToast(context:context, message: "Mileage is required");
    } else if (manufacturingController.text.isEmpty) {
      CommonMethods().showToast(context:context, message: "Manufacturing year is required");
    } else if (dateController.text.isEmpty) {
      return CommonMethods().showToast(context:context, message: "Date is required");
    } else if (priceController.text.isEmpty) {
      CommonMethods().showToast(context:context, message: "Price is required");
    } else if (addressController.text.isEmpty) {
      return CommonMethods().showToast(context:context, message: "Address is required");
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
        id: widget.myVehicleMarketPlace!=null? widget.myVehicleMarketPlace!.id:widget.myVehicle!.id!,
        brand_name: brandNameController.text,
        model_name: modelController.text,
        price: priceController.text,
        address_long: locationLang,
        address_lat: locationLat,
        color: selectedColor,
        address: addressController.text,
        capacity: engineController.text,
        car_image_3: image3,
        car_image_2: image2,
        car_image_1: image1,
        description: descriptionController.text,
        manufacturing_year: manufacturingController.text,
        mileage: mileage));
  }

  void getVehicleData() {
    if (widget.fromEdit) {
      if (widget.myVehicleMarketPlace != null) {
        brandNameController.text = widget.myVehicleMarketPlace!.brandName!;
        modelController.text = widget.myVehicleMarketPlace!.modelName!;
        priceController.text = widget.myVehicleMarketPlace!.price!;
        engineController.text = widget.myVehicleMarketPlace!.capacity!.toString();
        mileage = widget.myVehicleMarketPlace!.mileage!;
        dateController.text = widget.myVehicleMarketPlace!.createdAt!.toString();
        selectedColor = widget.myVehicleMarketPlace!.color!;
        manufacturingController.text = widget.myVehicleMarketPlace!.manufacturingYear!;
        descriptionController.text = widget.myVehicleMarketPlace!.description!;
        addressController.text = widget.myVehicleMarketPlace!.address!;
        updatedImage1 = widget.myVehicleMarketPlace!.carImage1!;
        updatedImage2 = widget.myVehicleMarketPlace!.carImage2!;
        updatedImage3 = widget.myVehicleMarketPlace!.carImage3!;
        if (mounted) {
          setState(() {});
        }
      }
      else{
        if (widget.myVehicle != null) {
          brandNameController.text = widget.myVehicle!.brandName!;
          modelController.text = widget.myVehicle!.modelName!;
          priceController.text = widget.myVehicle!.price!;
          engineController.text = widget.myVehicle!.capacity!.toString();
          mileage = widget.myVehicle!.mileage!;
          dateController.text = widget.myVehicle!.createdAt!.toString();
          selectedColor = widget.myVehicle!.color!;
          manufacturingController.text = widget.myVehicle!.manufacturingYear!;
          descriptionController.text = widget.myVehicle!.description!;
          addressController.text = widget.myVehicle!.address!;
          updatedImage1 = widget.myVehicle!.carImage1!;
          updatedImage2 = widget.myVehicle!.carImage2!;
          updatedImage3 = widget.myVehicle!.carImage3!;
          if (mounted) {
            setState(() {});
          }
        }
      }
    }
  }
}
