import 'dart:io';

import 'package:app/bloc/home/add_car/add_car_bloc.dart';
import 'package:app/bloc/home/view_cars/view_car_bloc.dart';
import 'package:app/common/location_util.dart';
import 'package:app/model/all_vehicle_model.dart';
import 'package:app/model/my_marketplace_vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/drop_down.dart';
import '../../common/ui/edit_text.dart';
import '../../common/ui/headers.dart';

class SellCar extends StatefulWidget {
  final bool fromEdit;
  final AllVehicleData? myVehicle ;
  final MyVehicleMarketPlace? myVehicleMarketPlace ;

  const SellCar({Key? key, this.fromEdit = false, this.myVehicleMarketPlace, this.myVehicle}) : super(key: key);

  @override
  State<SellCar> createState() => _SellCarState();
}

class _SellCarState extends State<SellCar> {
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _engineController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _manufacturingController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final DateTime _selectedDate = DateTime.now();
  String _selectedColor = "Black";
  String _mileage = AppConstants.mileageItems[0];
  String _image1 = "";
  String _image2 = '';
  String _image3 = "";
  String _updatedImage1 = "";
  String _updatedImage2 = "";
  String _updatedImage3 = "";
  double _locationLat = 0.0;
  double _locationLang = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    getVehicleData();
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime.now().subtract(const Duration(days: 7305)), lastDate: DateTime.now());
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
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
              CommonMethods().showToast(context: context, message: "Car added successfully" /*, isSuccess: true, title: "Success"*/);
            }
            if (state is UpdateCarSuccessFully) {
              BlocProvider.of<MyMarketVehicleBloc>(context).add(const MyMarketVehicleRequestEvent(
                isInitialLoadingState: true,
                isFetchingMoreLoadingState: false,
                isPaginationStartFromFirstPage: true,
              ));
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
                      MyEditText(AppConstants.brandText, false, TextInputType.text, TextCapitalization.none, 10.0, _brandNameController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      headingText(text: AppConstants.modelText),
                      verticalSpacer(height: 10.0),
                      MyEditText(AppConstants.modelText, false, TextInputType.text, TextCapitalization.none, 10.0, _modelController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      headingText(text: AppConstants.engineText),
                      verticalSpacer(height: 10.0),
                      MyEditText(AppConstants.engineText, false, TextInputType.text, TextCapitalization.none, 10.0, _engineController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      headingText(text: AppConstants.colorText),
                      verticalSpacer(height: 10.0),
                      AppDropdown(
                        bgColor: Colours.blue.code,
                        items: AppConstants.colorItems,
                        selectedItem: AppConstants.colorItems[0],
                        onChange: (String? val) {
                          _selectedColor = val!;
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
                            _mileage = value;
                            setState(() {});
                          }),
                      verticalSpacer(),
                      headingText(text: AppConstants.priceText),
                      verticalSpacer(height: 10.0),
                      MyEditText(r"$", false, TextInputType.number, TextCapitalization.none, 10.0, _priceController, Colours.hintColor.code, true),
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
                          _dateController,
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
                      MyEditText(AppConstants.manufacturingYearText, false, TextInputType.number, TextCapitalization.none, 10.0, _manufacturingController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      headingText(text: AppConstants.descriptionText),
                      verticalSpacer(height: 10.0),
                      MyEditText(
                        AppConstants.descriptionText,
                        false,
                        TextInputType.text,
                        TextCapitalization.none,
                        10.0,
                        _descriptionController,
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
                            if (position != null && mounted) {
                              LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PlacePicker(
                                        "AIzaSyBPFuOfeRqXLrspLP3_p7MmgL2OaLzg9nk",
                                      )));

                              // Handle the result in your way

                              if (mounted) {
                                setState(() {
                                  _locationLat = result.latLng!.latitude;
                                  _locationLang = result.latLng!.longitude;
                                  _addressController.text = result.formattedAddress!;
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
                          _addressController,
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
                                      _image1 = state.imagePath!;
                                    } else {
                                      _updatedImage1 = "";
                                      _image1 = state.imagePath!;
                                    }
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  }
                                }
                              },
                              child: _updatedImage1 != ""
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
                                              _updatedImage1,
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
                                      child: _image1 != ""
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
                                                      File(_image1),
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
                                      _image2 = state.imagePath!;
                                    } else {
                                      _updatedImage2 = "";
                                      _image2 = state.imagePath!;
                                    }
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  }
                                }
                              },
                              child: _updatedImage2 != ""
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
                                              _updatedImage2,
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
                                      child: _image2 != ""
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
                                                      File(_image2),
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
                                      _image3 = state.imagePath!;
                                    } else {
                                      _updatedImage3 = "";
                                      _image3 = state.imagePath!;
                                    }
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  }
                                }
                              },
                              child: _updatedImage3 != ""
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
                                              _updatedImage3,
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
                                      child: _image3 != ""
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
                                                      File(_image3),
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
    if (_brandNameController.text.isEmpty) {
      return CommonMethods().showToast(context: context, message: "Brand name is required");
    } else if (_modelController.text.isEmpty) {
      return CommonMethods().showToast(context: context, message: "Model is required");
    } else if (_engineController.text.isEmpty) {
      return CommonMethods().showToast(context: context, message: "Capacity is required");
    } else if (_selectedColor.isEmpty) {
      return CommonMethods().showToast(context: context, message: "Color is required");
    } else if (_selectedColor.isEmpty) {
      return CommonMethods().showToast(context: context, message: "Color is required");
    } else if (_descriptionController.text.isEmpty) {
      CommonMethods().showToast(context: context, message: "Description is required");
    } else if (_mileage.isEmpty) {
      return CommonMethods().showToast(context: context, message: "Mileage is required");
    } else if (_manufacturingController.text.isEmpty) {
      CommonMethods().showToast(context: context, message: "Manufacturing year is required");
    } else if (_dateController.text.isEmpty) {
      return CommonMethods().showToast(context: context, message: "Date is required");
    } else if (_priceController.text.isEmpty) {
      CommonMethods().showToast(context: context, message: "Price is required");
    } else if (_addressController.text.isEmpty) {
      return CommonMethods().showToast(context: context, message: "Address is required");
    } else {
      BlocProvider.of<SellCarBloc>(context).add(AddCarToSell(
          brandName: _brandNameController.text,
          modelName: _modelController.text,
          capacity: _engineController.text,
          color: _selectedColor,
          description: _descriptionController.text,
          mileage: _mileage,
          manufacturingYear: _manufacturingController.text,
          address: _addressController.text,
          price: _priceController.text,
          carImage_1: _image1,
          carImage_2: _image2.isNotEmpty ? _image2 : "",
          carImage_3: _image3.isNotEmpty ? _image3 : "",
          address_lat: _locationLat,
          address_long: _locationLang));
    }
  }

  void updateVehicleDetail() {
    BlocProvider.of<SellCarBloc>(context).add(UpdateCarToSell(
        id: widget.myVehicleMarketPlace != null ? widget.myVehicleMarketPlace!.id : widget.myVehicle!.id!,
        brandName: _brandNameController.text,
        modelName: _modelController.text,
        price: _priceController.text,
        address_long: _locationLang,
        address_lat: _locationLat,
        color: _selectedColor,
        address: _addressController.text,
        capacity: _engineController.text,
        carImage_3: _image3,
        carImage_2: _image2,
        carImage_1: _image1,
        description: _descriptionController.text,
        manufacturingYear: _manufacturingController.text,
        mileage: _mileage));
  }

  void getVehicleData() {
    if (widget.fromEdit) {
      if (widget.myVehicleMarketPlace != null) {
        _brandNameController.text = widget.myVehicleMarketPlace!.brandName!;
        _modelController.text = widget.myVehicleMarketPlace!.modelName!;
        _priceController.text = widget.myVehicleMarketPlace!.price!;
        _engineController.text = widget.myVehicleMarketPlace!.capacity!.toString();
        _mileage = widget.myVehicleMarketPlace!.mileage!;
        _dateController.text = widget.myVehicleMarketPlace!.createdAt!.toString();
        _selectedColor = widget.myVehicleMarketPlace!.color!;
        _manufacturingController.text = widget.myVehicleMarketPlace!.manufacturingYear!;
        _descriptionController.text = widget.myVehicleMarketPlace!.description!;
        _addressController.text = widget.myVehicleMarketPlace!.address!;
        _updatedImage1 = widget.myVehicleMarketPlace!.carImage1!;
        _updatedImage2 = widget.myVehicleMarketPlace!.carImage2!;
        _updatedImage3 = widget.myVehicleMarketPlace!.carImage3!;
        if (mounted) {
          setState(() {});
        }
      } else {
        if (widget.myVehicle != null) {
          _brandNameController.text = widget.myVehicle!.brandName!;
          _modelController.text = widget.myVehicle!.modelName!;
          _priceController.text = widget.myVehicle!.price!;
          _engineController.text = widget.myVehicle!.capacity!.toString();
          _mileage = widget.myVehicle!.mileage!;
          _dateController.text = widget.myVehicle!.createdAt!.toString();
          _selectedColor = widget.myVehicle!.color!;
          _manufacturingController.text = widget.myVehicle!.manufacturingYear!;
          _descriptionController.text = widget.myVehicle!.description!;
          _addressController.text = widget.myVehicle!.address!;
          _updatedImage1 = widget.myVehicle!.carImage1!;
          _updatedImage2 = widget.myVehicle!.carImage2!;
          _updatedImage3 = widget.myVehicle!.carImage3!;
          if (mounted) {
            setState(() {});
          }
        }
      }
    }
  }
}
