import 'dart:io';
import 'package:app/common/ui/avatar.dart';
import 'package:app/common/ui/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:place_picker/place_picker.dart';
import '../../bloc/profile/create/create_profile_bloc.dart';
import '../../bloc/profile/view/profile_bloc.dart';
import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/location_util.dart';
import '../../common/methods/common.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/drop_down.dart';
import '../../common/ui/edit_text.dart';
import '../../common/ui/headers.dart';
import '../vehicle/vehicle_details.dart';

class ProfileSetUpScreen extends StatefulWidget {
  final bool fromEdit;

  const ProfileSetUpScreen({Key? key, this.fromEdit = false}) : super(key: key);

  @override
  State<ProfileSetUpScreen> createState() => _ProfileSetUpScreenState();
}

class _ProfileSetUpScreenState extends State<ProfileSetUpScreen> {
  final TextEditingController _fNameController = TextEditingController(/*text: kDebugMode ? "Test fName" : ""*/);
  final TextEditingController _lNameController = TextEditingController(/*text: kDebugMode ? "Test lName" : ""*/);
  final TextEditingController _mobileController = TextEditingController(/*text: kDebugMode ? "9090909090" : ""*/);
  final TextEditingController _addressController = TextEditingController(/*text: kDebugMode ? "Mohali Phase 3B2" : ""*/);
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardExpDateController = TextEditingController();
  final TextEditingController _cardCvvController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  int _selectedGender = 1;
  String _genderText = AppConstants.genderItems[0];
  String? _selectedPaymentOption;
  bool _showAddCard = false;
  File? _selectedImage;
  String? _imageUrl;
  double _locationLat = 0.0;
  double _locationLang = 0.0;

  @override
  void initState() {
    super.initState();
    var state = context.read<ProfileBloc>().state;
    if (state is ProfileLoaded) {
      _fNameController.text = state.userProfile.user?.firstName ?? "";
      _lNameController.text = state.userProfile.user?.lastName ?? "";
      _mobileController.text = state.userProfile.user?.mobile ?? "";
      _addressController.text = state.userProfile.user?.address ?? "";
      _genderText = state.userProfile.user?.getGenderText ?? "";
      _imageUrl = state.userProfile.user?.userImage;
      _locationLat = (state.userProfile.user != null && state.userProfile.user?.addressLat != null ? double.tryParse(state.userProfile.user!.addressLat!) : 0.0) ?? 0.0;
      _locationLang = (state.userProfile.user != null && state.userProfile.user?.addressLong != null ? double.tryParse(state.userProfile.user!.addressLong!) : 0.0) ?? 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocListener<CreateProfileBloc, CreateProfileState>(
        listener: (BuildContext context, state) {
          if (state is CreatedSuccessfully) {
            CommonMethods().showToast(context: context, message: state.success);
            Navigator.of(context, rootNavigator: true).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => const VehicleDetails(),
              ),
            );
          }
          if (state is UpdateProfileSuccessfully) {
            Navigator.of(context).pop();
            context.read<ProfileBloc>().add(ProfileFetchEvent());
          }
          if (state is CreatedFailed) {
            CommonMethods().showToast(context: context, message: state.error);
          }
        },
        child: BlocBuilder<CreateProfileBloc, CreateProfileState>(builder: (context, state) {
          return Scaffold(
            body: BackgroundImage(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(bottom: false, child: AppHeaders().extendedHeader(text: widget.fromEdit ? AppConstants.editProfile : AppConstants.setup, context: context)),
                  verticalSpacer(
                    height: 40.0,
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
                          Avatar(
                            radius: 50.0,
                            isCamera: true,
                            imagePath: widget.fromEdit && _selectedImage == null
                                ? _imageUrl!
                                : _selectedImage == null
                                    ? ""
                                    : _selectedImage!.path,
                            isFile: _selectedImage != null ? true : false,
                            fromUrl: widget.fromEdit && _selectedImage == null ? true : false,
                            onSelect: () async {
                              _selectedImage = await CommonMethods().showAlertDialog(context);
                              if (mounted) setState(() {});
                            },
                          ),
                          verticalSpacer(),
                          headingText(text: AppConstants.userName),
                          verticalSpacer(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                child: MyEditText(AppConstants.fNameHint, false, TextInputType.text, TextCapitalization.none, 10.0, _fNameController, Colours.hintColor.code, true),
                              ),
                              horizontalSpacer(),
                              Expanded(
                                child: MyEditText(AppConstants.lNameHint, false, TextInputType.text, TextCapitalization.none, 10.0, _lNameController, Colours.hintColor.code, true),
                              ),
                            ],
                          ),
                          verticalSpacer(),
                          headingText(text: AppConstants.genderHint),
                          verticalSpacer(height: 10.0),
                          AppDropdown(
                            bgColor: Colours.blue.code,
                            items: AppConstants.genderItems,
                            selectedItem: _genderText,
                            onChange: (item) {
                              if (item == AppConstants.genderItems[0]) {
                                _selectedGender = 1;
                              }
                              if (item == AppConstants.genderItems[1]) {
                                _selectedGender = 2;
                              }
                              if (item == AppConstants.genderItems[2]) {
                                _selectedGender = 3;
                              }
                            },
                          ),
                          verticalSpacer(),
                          headingText(text: AppConstants.mobileHint),
                          verticalSpacer(height: 10.0),
                          MyEditText(AppConstants.mobileHint, false, TextInputType.phone, TextCapitalization.none, 10.0, _mobileController, Colours.hintColor.code, true),
                          verticalSpacer(),
                          headingText(text: AppConstants.addressHint),
                          verticalSpacer(height: 10.0),
                          MyEditText(
                            AppConstants.addressExp,
                            false,
                            TextInputType.streetAddress,
                            TextCapitalization.none,
                            10.0,
                            _addressController,
                            Colours.hintColor.code,
                            true,
                            isSuffix: true,
                            suffixIcon: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                try {
                                  Position? position = await LocationUtil.getLocation();
                                  if (position != null && mounted) {
                                    LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => PlacePicker(
                                              "AIzaSyBPFuOfeRqXLrspLP3_p7MmgL2OaLzg9nk",
                                            )));

                                    // Handle the result in your way

                                    if (mounted && result != null) {
                                      setState(() {
                                        _locationLat = result.latLng!.latitude;
                                        _locationLang = result.latLng!.longitude;
                                        _addressController.text = result.formattedAddress!;
                                      });
                                    }
                                    /*LatLng latLng = LatLng(position.latitude, position.longitude);
                                    //void showPlacePicker() async {
                                    Map<String, dynamic>? result = await Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => PlacePicker(
                                              displayLocation: latLng,
                                            )));

                                    if (mounted && result != null && result.isNotEmpty) {
                                      setState(() {
                                        locationResult = result;
                                        addressController.text = result['address'];
                                      });
                                    }*/
                                  }
                                } catch (e) {
                                  debugPrint(e.toString());
                                }
                              },
                              child: Icon(
                                Icons.location_pin,
                                color: Colours.blue.code,
                              ),
                            ),
                          ),
                          verticalSpacer(),
                          headingText(text: AppConstants.paymentHint),
                          verticalSpacer(height: 10.0),
                          AppDropdown(
                            bgColor: Colours.blue.code,
                            items: AppConstants.paymentItems,
                            selectedItem: AppConstants.paymentItems[0],
                            onChange: (value) {
                              _selectedPaymentOption = value;
                              if (_selectedPaymentOption == AppConstants.paymentItems[1] || _selectedPaymentOption == AppConstants.paymentItems[2]) {
                                _showAddCard = true;
                              } else {
                                _showAddCard = false;
                              }
                              setState(() {});
                            },
                          ),
                          verticalSpacer(),
                          if (!_showAddCard)
                            state is LoadingUpdate
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : submitButton(),
                          verticalSpacer(height: _showAddCard ? 20 : 50),
                          if (_showAddCard)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                headingText(text: AppConstants.cardNumberHint),
                                verticalSpacer(height: 10.0),
                                MyEditText(
                                  AppConstants.cardNumberHint,
                                  false,
                                  const TextInputType.numberWithOptions(),
                                  TextCapitalization.none,
                                  10.0,
                                  _cardNumberController,
                                  Colours.hintColor.code,
                                  true,
                                ),
                                verticalSpacer(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: headingText(text: AppConstants.cardExpDateHint),
                                    ),
                                    horizontalSpacer(),
                                    Expanded(
                                      child: headingText(text: AppConstants.cardCvvHint),
                                    ),
                                  ],
                                ),
                                verticalSpacer(height: 10.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: MyEditText(AppConstants.cardExpDateHint, false, const TextInputType.numberWithOptions(), TextCapitalization.none, 10.0, _cardExpDateController,
                                          Colours.hintColor.code, true),
                                    ),
                                    horizontalSpacer(),
                                    Expanded(
                                      child: MyEditText(AppConstants.cardCvvHint, false, TextInputType.number, TextCapitalization.none, 10.0, _cardCvvController, Colours.hintColor.code, true),
                                    ),
                                  ],
                                ),
                                verticalSpacer(),
                                headingText(text: AppConstants.cardNameHint),
                                verticalSpacer(height: 10.0),
                                MyEditText(
                                  AppConstants.cardNameHint,
                                  false,
                                  TextInputType.text,
                                  TextCapitalization.none,
                                  10.0,
                                  _cardNameController,
                                  Colours.hintColor.code,
                                  true,
                                ),
                                verticalSpacer(),
                                /* state is LoadingUpdate
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    :*/
                                submitButton(),
                                verticalSpacer(height: 50),
                              ],
                            )
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  validate() {
    if (_fNameController.text == "") {
      CommonMethods().showToast(context: context, message: "First name is required.");
      return;
    }
    if (_lNameController.text == "") {
      CommonMethods().showToast(context: context, message: "Last name is required.");
      return;
    }
    if (_mobileController.text == "") {
      CommonMethods().showToast(context: context, message: "Phone number is required.");
      return;
    }
    if (_mobileController.text.length < 10) {
      CommonMethods().showToast(context: context, message: "Invalid Phone number.");
      return;
    }
    if (_addressController.text == "") {
      CommonMethods().showToast(context: context, message: "Address is required.");
      return;
    }
    if (_mobileController.text.length < 8) {
      CommonMethods().showToast(context: context, message: "Please enter full address or select from map.");
      return;
    }
    if (_selectedImage == null) {
      CommonMethods().showToast(context: context, message: "Please select avatar image.");
      return;
    }
    _createUpdateProfile(context);
  }

  void _createUpdateProfile(BuildContext context) {
    BlocProvider.of<CreateProfileBloc>(context).add(
      CreateProfileRequested(
        _fNameController.text,
        _lNameController.text,
        _mobileController.text.replaceAll(" ", ""),
        _addressController.text,
        _selectedGender,
        _selectedImage!.path,
        _locationLat,
        _locationLang,
      ),
    );
  }

  Widget submitButton() => GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        validate();
      },
      child: appButton(bkColor: Colours.blue.code, text: widget.fromEdit ? AppConstants.update : AppConstants.submitText));
}
