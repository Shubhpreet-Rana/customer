import 'package:app/common/ui/avatar.dart';
import 'package:app/common/ui/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/drop_down.dart';
import '../../common/ui/edit_text.dart';
import '../../common/ui/headers.dart';
import '../vehicle/vehicle_details.dart';

class ProfileSetUp extends StatefulWidget {
  const ProfileSetUp({Key? key}) : super(key: key);

  @override
  State<ProfileSetUp> createState() => _ProfileSetUpState();
}

class _ProfileSetUpState extends State<ProfileSetUp> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardExpDateController = TextEditingController();
  TextEditingController cardCvvController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  String? selectedPaymentOption;
  bool showAddCard = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(bottom: false, child: AppHeaders().extendedHeader(text: AppConstants.setup, context: context)),
            verticalSpacer(
              height: 60.0,
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
                    const Avatar(
                      radius: 50.0,
                      isCamera: true,
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
                      selectedItem: AppConstants.genderItems[0],
                    ),
                    verticalSpacer(),
                    headingText(text: AppConstants.mobileHint),
                    verticalSpacer(height: 10.0),
                    MyEditText(AppConstants.mobileHint, false, TextInputType.phone, TextCapitalization.none, 10.0, mobileController,
                        Colours.hintColor.code, true),
                    verticalSpacer(),
                    headingText(text: AppConstants.addressHint),
                    verticalSpacer(height: 10.0),
                    MyEditText(
                      AppConstants.addressHint,
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
                    if (!showAddCard) submitButton(),
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
                                child: MyEditText(AppConstants.cardExpDateHint, false, const TextInputType.numberWithOptions(),
                                    TextCapitalization.none, 10.0, cardExpDateController, Colours.hintColor.code, true),
                              ),
                              horizontalSpacer(),
                              Expanded(
                                child: MyEditText(AppConstants.cardCvvHint, false, TextInputType.number, TextCapitalization.none, 10.0,
                                    cardCvvController, Colours.hintColor.code, true),
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
  }

  Widget submitButton() => GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => const VehicleDetails()));
      },
      child: appButton(bkColor: Colours.blue.code, text: AppConstants.submitText));
}
