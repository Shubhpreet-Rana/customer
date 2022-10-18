import 'dart:io';

import 'package:app/common/ui/avatar.dart';
import 'package:app/common/ui/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
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
import '../maps/pick_location.dart';
import '../vehicle/vehicle_details.dart';

class ProfileSetUp extends StatefulWidget {
  final bool fromEdit;

  const ProfileSetUp({Key? key, this.fromEdit = false}) : super(key: key);

  @override
  State<ProfileSetUp> createState() => _ProfileSetUpState();
}

class _ProfileSetUpState extends State<ProfileSetUp> {
  TextEditingController fNameController = TextEditingController(text: kDebugMode ? "Test fName" : "");
  TextEditingController lNameController = TextEditingController(text: kDebugMode ? "Test lName" : "");
  TextEditingController mobileController = TextEditingController(text: kDebugMode ? "9090909090" : "");
  TextEditingController addressController = TextEditingController(text: kDebugMode ? "Mohali Phase 3B2" : "");
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardExpDateController = TextEditingController();
  TextEditingController cardCvvController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  int selectedGender = 1;
  String genderText = AppConstants.genderItems[0];
  String? selectedPaymentOption;
  bool showAddCard = false;
  File? selectedImage;
  String? imageUrl;
  double locationLat = 0.0;
  double locationLang = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var state = context.read<ProfileBloc>().state;
    if (state is ProfileLoaded) {
      fNameController.text = state.userProfile.user!.firstName ?? "";
      lNameController.text = state.userProfile.user!.lastName ?? "";
      mobileController.text = state.userProfile.user!.mobile ?? "";
      addressController.text = state.userProfile.user!.address ?? "";
      genderText = state.userProfile.user!.getGenderText;
      imageUrl = state.userProfile.user!.userImage;
      locationLat =(state.userProfile.user!.addressLat!=null? double.tryParse(state.userProfile.user!.addressLat!): 0.0)!;
      locationLang =(state.userProfile.user!.addressLong!=null? double.tryParse(state.userProfile.user!.addressLong!): 0.0)!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateProfileBloc, CreateProfileState>(
      listener: (context, state) {
        if (state is CreatedSuccessfully) {
          CommonMethods().showToast(context: context, message: state.success);
          Navigator.of(context, rootNavigator: true)
              .pushReplacement(CupertinoPageRoute(builder: (context) => const VehicleDetails()));
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
                SafeArea(
                    bottom: false,
                    child: AppHeaders()
                        .extendedHeader(text: widget.fromEdit ? AppConstants.editProfile : AppConstants.setup, context: context)),
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
                          imagePath: widget.fromEdit && selectedImage == null
                              ? imageUrl!
                              : selectedImage == null
                                  ? ""
                                  : selectedImage!.path,
                          isFile: selectedImage != null ? true : false,
                          fromUrl: widget.fromEdit && selectedImage == null ? true : false,
                          onSelect: () async {
                            selectedImage = await CommonMethods().showAlertDialog(context);
                            print(selectedImage);
                            if (mounted) setState(() {});
                          },
                        ),
                        verticalSpacer(),
                        headingText(text: AppConstants.userName),
                        verticalSpacer(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              child: MyEditText(AppConstants.fNameHint, false, TextInputType.text, TextCapitalization.none, 10.0,
                                  fNameController, Colours.hintColor.code, true),
                            ),
                            horizontalSpacer(),
                            Expanded(
                              child: MyEditText(AppConstants.lNameHint, false, TextInputType.text, TextCapitalization.none, 10.0,
                                  lNameController, Colours.hintColor.code, true),
                            ),
                          ],
                        ),
                        verticalSpacer(),
                        headingText(text: AppConstants.genderHint),
                        verticalSpacer(height: 10.0),
                        AppDropdown(
                          bgColor: Colours.blue.code,
                          items: AppConstants.genderItems,
                          selectedItem: genderText,
                          onChange: (item) {
                            if (item == AppConstants.genderItems[0]) {
                              selectedGender = 1;
                            }
                            if (item == AppConstants.genderItems[1]) {
                              selectedGender = 2;
                            }
                            if (item == AppConstants.genderItems[2]) {
                              selectedGender = 3;
                            }
                          },
                        ),
                        verticalSpacer(),
                        headingText(text: AppConstants.mobileHint),
                        verticalSpacer(height: 10.0),
                        MyEditText(AppConstants.mobileHint, false, TextInputType.phone, TextCapitalization.none, 10.0,
                            mobileController, Colours.hintColor.code, true),
                        verticalSpacer(),
                        headingText(text: AppConstants.addressHint),
                        verticalSpacer(height: 10.0),
                        MyEditText(
                          AppConstants.addressExp,
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
                                  print(result);

                                  if (mounted && result != null) {
                                    setState(() {
                                      locationLat = result.latLng!.latitude;
                                      locationLang = result.latLng!.longitude;
                                      addressController.text = result.formattedAddress!;
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
                        headingText(text: AppConstants.paymentHint),
                        verticalSpacer(height: 10.0),
                        AppDropdown(
                          bgColor: Colours.blue.code,
                          items: AppConstants.paymentItems,
                          selectedItem: AppConstants.paymentItems[0],
                          onChange: (value) {
                            selectedPaymentOption = value;
                            if (selectedPaymentOption == AppConstants.paymentItems[1] ||
                                selectedPaymentOption == AppConstants.paymentItems[2]) {
                              showAddCard = true;
                            } else {
                              showAddCard = false;
                            }
                            setState(() {});
                          },
                        ),
                        verticalSpacer(),
                        if (!showAddCard)
                          state is LoadingUpdate
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : submitButton(),
                        verticalSpacer(height: showAddCard ? 20 : 50),
                        if (showAddCard)
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
                                cardNumberController,
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
                                    child: MyEditText(
                                        AppConstants.cardExpDateHint,
                                        false,
                                        const TextInputType.numberWithOptions(),
                                        TextCapitalization.none,
                                        10.0,
                                        cardExpDateController,
                                        Colours.hintColor.code,
                                        true),
                                  ),
                                  horizontalSpacer(),
                                  Expanded(
                                    child: MyEditText(AppConstants.cardCvvHint, false, TextInputType.number,
                                        TextCapitalization.none, 10.0, cardCvvController, Colours.hintColor.code, true),
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
                                cardNameController,
                                Colours.hintColor.code,
                                true,
                              ),
                              verticalSpacer(),
                             /* state is LoadingUpdate
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  :*/ submitButton(),
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
    );
  }

  validate() {
    if (fNameController.text == "") {
      CommonMethods().showToast(context: context, message: "First name is required.");
      return;
    }
    if (lNameController.text == "") {
      CommonMethods().showToast(context: context, message: "Last name is required.");
      return;
    }
    if (mobileController.text == "") {
      CommonMethods().showToast(context: context, message: "Phone number is required.");
      return;
    }
    if (mobileController.text.length < 10) {
      CommonMethods().showToast(context: context, message: "Invalid Phone number.");
      return;
    }
    if (addressController.text == "") {
      CommonMethods().showToast(context: context, message: "Address is required.");
      return;
    }
    if (mobileController.text.length < 8) {
      CommonMethods().showToast(context: context, message: "Please enter full address or select from map.");
      return;
    }
    if (selectedImage == null) {
      CommonMethods().showToast(context: context, message: "Please select avatar image.");
      return;
    }
    _createUpdateProfile(context);
  }

  void _createUpdateProfile(BuildContext context) {
    BlocProvider.of<CreateProfileBloc>(context).add(
      CreateProfileRequested(fNameController.text, lNameController.text, mobileController.text, addressController.text,
          selectedGender, selectedImage!.path, locationLat, locationLang),
    );
  }

  Widget submitButton() => GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        validate();

      },
      child: appButton(bkColor: Colours.blue.code, text: widget.fromEdit ? AppConstants.update : AppConstants.submitText));
}
