import 'dart:io';

import 'package:app/bloc/vehicle/add/add_vehicle_bloc.dart';
import 'package:app/common/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/drop_down.dart';
import '../../common/ui/edit_text.dart';
import '../../common/ui/headers.dart';
import '../home/home_tabs.dart';

class VehicleDetails extends StatefulWidget {
  final bool fromEdit;

  const VehicleDetails({Key? key, this.fromEdit = false}) : super(key: key);

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  TextEditingController brandNameController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  XFile? selectedImageA;
  XFile? selectedImageB;
  XFile? selectedImageC;
  String selectedColor = AppConstants.colorItems[0];
  String selectedMileage = AppConstants.mileageItems[0];

  TextEditingController brandNameController1 = TextEditingController();
  TextEditingController modelController1 = TextEditingController();
  TextEditingController engineController1 = TextEditingController();
  TextEditingController priceController1 = TextEditingController();
  TextEditingController dateController1 = TextEditingController();
  TextEditingController descriptionController1 = TextEditingController();
  XFile? selectedImageA1;
  XFile? selectedImageB1;
  XFile? selectedImageC1;
  String selectedColor1 = AppConstants.colorItems[0];
  String selectedMileage1 = AppConstants.mileageItems[0];

  TextEditingController brandNameController2 = TextEditingController();
  TextEditingController modelController2 = TextEditingController();
  TextEditingController engineController2 = TextEditingController();
  TextEditingController priceController2 = TextEditingController();
  TextEditingController dateController2 = TextEditingController();
  TextEditingController descriptionController2 = TextEditingController();
  XFile? selectedImageA2;
  XFile? selectedImageB2;
  XFile? selectedImageC2;
  String selectedColor2 = AppConstants.colorItems[0];
  String selectedMileage2 = AppConstants.mileageItems[0];

  DateTime? selectedDate;

  int selectedTab = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 7305)));
    if (picked != null && picked != selectedDate) {
      String date = DateFormat('dd MMM, yyyy').format(picked);
      if (selectedTab == 1) {
        dateController.text = date;
      }
      if (selectedTab == 2) {
        dateController1.text = date;
      }
      if (selectedTab == 3) {
        dateController2.text = date;
      }
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddVehicleBloc, AddVehicleState>(
      listener: (context, state) {
        if (state is AddedSuccessfully) {
          CommonMethods().showTopFlash(context: context, message: state.success, isSuccess: true);
          Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => const HomeTabs()));
        }
        if (state is AddVehicleFailed) {
          CommonMethods().showTopFlash(context: context, message: state.error);
        }
      },
      child: BlocBuilder<AddVehicleBloc, AddVehicleState>(builder: (context, state) {
        return Scaffold(
          body: BackgroundImage(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                    bottom: false,
                    child: AppHeaders().extendedHeader(
                        text: widget.fromEdit ? AppConstants.editProfile : AppConstants.vehicle, context: context)),
                verticalSpacer(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, top: 20.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            selectedTab = 1;
                          });
                        },
                        child: Text(
                          AppConstants.carText1,
                          style: selectedTab == 1 ? AppStyles.whiteText : AppStyles.blueLightText,
                        ),
                      ),
                      horizontalSpacer(width: 30.0),
                      GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            setState(() {
                              selectedTab = 2;
                            });
                          },
                          child: Text(AppConstants.carText2,
                              style: selectedTab == 2 ? AppStyles.whiteText : AppStyles.blueLightText)),
                      horizontalSpacer(width: 30.0),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            selectedTab = 3;
                          });
                        },
                        child: Text(
                          AppConstants.carText3,
                          style: selectedTab == 3 ? AppStyles.whiteText : AppStyles.blueLightText,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpacer(
                  height: 20.0,
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
                        MyEditText(
                          AppConstants.brandText,
                          false,
                          TextInputType.text,
                          TextCapitalization.none,
                          10.0,
                          selectedTab == 1
                              ? brandNameController
                              : selectedTab == 2
                                  ? brandNameController1
                                  : brandNameController2,
                          Colours.hintColor.code,
                          true,
                          textInputAction: TextInputAction.next,
                        ),
                        verticalSpacer(),
                        headingText(text: AppConstants.modelText),
                        verticalSpacer(height: 10.0),
                        MyEditText(
                          AppConstants.modelText,
                          false,
                          TextInputType.text,
                          TextCapitalization.none,
                          10.0,
                          selectedTab == 1
                              ? modelController
                              : selectedTab == 2
                                  ? modelController1
                                  : modelController2,
                          Colours.hintColor.code,
                          true,
                          textInputAction: TextInputAction.next,
                        ),
                        verticalSpacer(),
                        headingText(text: AppConstants.engineText),
                        verticalSpacer(height: 10.0),
                        MyEditText(
                          AppConstants.engineText,
                          false,
                          TextInputType.text,
                          TextCapitalization.none,
                          10.0,
                          selectedTab == 1
                              ? engineController
                              : selectedTab == 2
                                  ? engineController1
                                  : engineController2,
                          Colours.hintColor.code,
                          true,
                          textInputAction: TextInputAction.next,
                        ),
                        verticalSpacer(),
                        headingText(text: AppConstants.colorText),
                        verticalSpacer(height: 10.0),
                        AppDropdown(
                          bgColor: Colours.blue.code,
                          items: AppConstants.colorItems,
                          selectedItem: AppConstants.colorItems[0],
                          onChange: (val) {
                            if (selectedTab == 1) {
                              selectedColor = val;
                            }
                            if (selectedTab == 2) {
                              selectedColor = val;
                            }
                            if (selectedTab == 3) {
                              selectedColor = val;
                            }
                          },
                        ),
                        verticalSpacer(),
                        headingText(text: AppConstants.mileageText),
                        verticalSpacer(height: 10.0),
                        AppDropdown(
                          bgColor: Colours.blue.code,
                          items: AppConstants.mileageItems,
                          selectedItem: AppConstants.mileageItems[0],
                          onChange: (String val) {
                            if (selectedTab == 1) {
                              selectedMileage = val;
                            }
                            if (selectedTab == 2) {
                              selectedMileage1 = val;
                            }
                            if (selectedTab == 3) {
                              selectedMileage2 = val;
                            }
                          },
                        ),
                        verticalSpacer(),
                        headingText(text: AppConstants.priceText),
                        verticalSpacer(height: 10.0),
                        MyEditText(
                          r"$",
                          false,
                          TextInputType.number,
                          TextCapitalization.none,
                          10.0,
                          selectedTab == 1
                              ? priceController
                              : selectedTab == 2
                                  ? priceController1
                                  : priceController2,
                          Colours.hintColor.code,
                          true,
                          textInputAction: TextInputAction.next,
                        ),
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
                            selectedTab == 1
                                ? dateController
                                : selectedTab == 2
                                    ? dateController1
                                    : dateController2,
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
                        headingText(text: AppConstants.descriptionText),
                        verticalSpacer(height: 10.0),
                        MyEditText(
                          AppConstants.descriptionText,
                          false,
                          TextInputType.text,
                          TextCapitalization.none,
                          10.0,
                          selectedTab == 1
                              ? descriptionController
                              : selectedTab == 2
                                  ? descriptionController1
                                  : descriptionController2,
                          Colours.hintColor.code,
                          true,
                          maxLine: 4,
                          textInputAction: TextInputAction.done,
                        ),
                        verticalSpacer(),
                        headingText(text: AppConstants.imageText),
                        verticalSpacer(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () async {
                                  var result = await CommonMethods().showAlertDialog(context, imageQuality: 70);
                                  if (selectedTab == 1) {
                                    selectedImageA = result;
                                  }
                                  if (selectedTab == 2) {
                                    selectedImageA1 = result;
                                  }
                                  if (selectedTab == 3) {
                                    selectedImageA2 = result;
                                  }
                                  if (mounted) setState(() {});
                                },
                                child: grayContainer(
                                    text: AppConstants.imageText1,
                                    icon: Icon(
                                      Icons.add,
                                      color: Colours.blue.code,
                                    ),
                                    paddingHorizontal: 15.0,
                                    paddingVertical: 15.0,
                                    child: selectedTab == 1 && selectedImageA != null
                                        ? carImage(selectedImageA!.path)
                                        : selectedTab == 2 && selectedImageA1 != null
                                            ? carImage(selectedImageA1!.path)
                                            : selectedTab == 3 && selectedImageA2 != null
                                                ? carImage(selectedImageA2!.path)
                                                : null),
                              ),
                            ),
                            horizontalSpacer(width: 10.0),
                            Expanded(
                                child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                var result = await CommonMethods().showAlertDialog(context, imageQuality: 70);
                                if (selectedTab == 1) {
                                  selectedImageB = result;
                                }
                                if (selectedTab == 2) {
                                  selectedImageB1 = result;
                                }
                                if (selectedTab == 3) {
                                  selectedImageB2 = result;
                                }
                                if (mounted) setState(() {});
                              },
                              child: grayContainer(
                                  text: AppConstants.imageText1,
                                  icon: Icon(Icons.add, color: Colours.blue.code),
                                  paddingHorizontal: 15.0,
                                  paddingVertical: 15.0,
                                  child: selectedTab == 1 && selectedImageB != null
                                      ? carImage(selectedImageB!.path)
                                      : selectedTab == 2 && selectedImageB1 != null
                                          ? carImage(selectedImageB1!.path)
                                          : selectedTab == 3 && selectedImageB2 != null
                                              ? carImage(selectedImageB2!.path)
                                              : null),
                            )),
                            horizontalSpacer(width: 10.0),
                            Expanded(
                                child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                var result = await CommonMethods().showAlertDialog(context, imageQuality: 70);
                                if (selectedTab == 1) {
                                  selectedImageC = result;
                                }
                                if (selectedTab == 2) {
                                  selectedImageC1 = result;
                                }
                                if (selectedTab == 3) {
                                  selectedImageC2 = result;
                                }
                                if (mounted) setState(() {});
                              },
                              child: grayContainer(
                                  text: AppConstants.imageText1,
                                  icon: Icon(Icons.add, color: Colours.blue.code),
                                  paddingHorizontal: 15.0,
                                  paddingVertical: 15.0,
                                  child: selectedTab == 1 && selectedImageC != null
                                      ? carImage(selectedImageC!.path)
                                      : selectedTab == 2 && selectedImageC1 != null
                                          ? carImage(selectedImageC1!.path)
                                          : selectedTab == 3 && selectedImageC2 != null
                                              ? carImage(selectedImageC2!.path)
                                              : null),
                            ))
                          ],
                        ),
                        verticalSpacer(),
                        state is LoadingUpdate
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  if (widget.fromEdit) {
                                    Navigator.of(context).pop();
                                  } else {
                                    validate();
                                  }
                                },
                                child: appButton(
                                    bkColor: Colours.blue.code,
                                    text: widget.fromEdit ? AppConstants.update : AppConstants.saveText)),
                        verticalSpacer(),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget carImage(String path) => ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.file(
        File(path),
        height: 85.0,
        fit: BoxFit.cover,
      ));

  validate() {
    bool car1Entry = false;
    bool car2Entry = false;
    bool car3Entry = false;
    List<Car> cars = [];
    if (brandNameController.text.isNotEmpty ||
        modelController.text.isNotEmpty ||
        engineController.text.isNotEmpty ||
        priceController.text.isNotEmpty ||
        dateController.text.isNotEmpty ||
        descriptionController.text.isNotEmpty ||
        selectedImageA != null ||
        selectedImageB != null ||
        selectedImageC != null) {
      car1Entry = true;
    }
    if (brandNameController1.text.isNotEmpty ||
        modelController1.text.isNotEmpty ||
        engineController1.text.isNotEmpty ||
        priceController1.text.isNotEmpty ||
        dateController1.text.isNotEmpty ||
        descriptionController1.text.isNotEmpty ||
        selectedImageA1 != null ||
        selectedImageB1 != null ||
        selectedImageC1 != null) {
      car2Entry = true;
    }
    if (brandNameController2.text.isNotEmpty ||
        modelController2.text.isNotEmpty ||
        engineController2.text.isNotEmpty ||
        priceController2.text.isNotEmpty ||
        dateController2.text.isNotEmpty ||
        descriptionController2.text.isNotEmpty ||
        selectedImageA2 != null ||
        selectedImageB2 != null ||
        selectedImageC2 != null) {
      car3Entry = true;
    }
    if (car1Entry) {
      if (brandNameController.text.isEmpty ||
          modelController.text.isEmpty ||
          engineController.text.isEmpty ||
          priceController.text.isEmpty ||
          dateController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          selectedImageA == null ||
          selectedImageB == null ||
          selectedImageC == null) {
        CommonMethods().showTopFlash(context: context, message: "All fields are required for car1");
        return;
      } else {
        cars.add(Car(
            brandNameController.text,
            modelController.text,
            engineController.text,
            selectedColor,
            selectedMileage,
            priceController.text,
            dateController.text,
            descriptionController.text,
            selectedImageA!.path,
            selectedImageB!.path,
            selectedImageC!.path));
      }
    }
    if (car2Entry) {
      if (brandNameController1.text.isEmpty ||
          modelController1.text.isEmpty ||
          engineController1.text.isEmpty ||
          priceController1.text.isEmpty ||
          dateController1.text.isEmpty ||
          descriptionController1.text.isEmpty ||
          selectedImageA1 == null ||
          selectedImageB1 == null ||
          selectedImageC1 == null) {
        CommonMethods().showTopFlash(context: context, message: "All fields are required for car2");
        return;
      } else {
        cars.add(Car(
            brandNameController1.text,
            modelController1.text,
            engineController1.text,
            selectedColor1,
            selectedMileage1,
            priceController1.text,
            dateController1.text,
            descriptionController1.text,
            selectedImageA1!.path,
            selectedImageB1!.path,
            selectedImageC1!.path));
      }
    }
    if (car3Entry) {
      if (brandNameController2.text.isEmpty ||
          modelController2.text.isEmpty ||
          engineController2.text.isEmpty ||
          priceController2.text.isEmpty ||
          dateController2.text.isEmpty ||
          descriptionController2.text.isEmpty ||
          selectedImageA2 == null ||
          selectedImageB2 == null ||
          selectedImageC2 == null) {
        CommonMethods().showTopFlash(context: context, message: "All fields are required for car3");
        return;
      } else {
        cars.add(Car(
            brandNameController2.text,
            modelController2.text,
            engineController2.text,
            selectedColor2,
            selectedMileage2,
            priceController2.text,
            dateController2.text,
            descriptionController2.text,
            selectedImageA2!.path,
            selectedImageB2!.path,
            selectedImageC2!.path));
      }
    }
    _addVehicle(context, cars);
  }

  void _addVehicle(BuildContext context, List<Car> cars) {
    BlocProvider.of<AddVehicleBloc>(context).add(AddVehicleRequested(cars));
  }
}

class Car {
  String brand;
  String model;
  String engine;
  String color;
  String mileage;
  String price;
  String dateOfService;
  String description;
  String image1;
  String image2;
  String image3;

  Car(this.brand, this.model, this.engine, this.color, this.mileage, this.price, this.dateOfService, this.description,
      this.image1, this.image2, this.image3);
}
