import 'package:app/common/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  const VehicleDetails({Key? key}) : super(key: key);

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
  int selectedTab = 1;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime.now().subtract(const Duration(days: 7305)), lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(bottom: false, child: AppHeaders().extendedHeader(text: AppConstants.vehicle, context: context)),
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
                      child: Text(AppConstants.carText2, style: selectedTab == 2 ? AppStyles.whiteText : AppStyles.blueLightText)),
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
                    ),
                    verticalSpacer(),
                    headingText(text: AppConstants.mileageText),
                    verticalSpacer(height: 10.0),
                    AppDropdown(
                      bgColor: Colours.blue.code,
                      items: AppConstants.mileageItems,
                      selectedItem: AppConstants.mileageItems[0],
                    ),
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
                    headingText(text: AppConstants.imageText),
                    verticalSpacer(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        grayContainer(
                            text: AppConstants.imageText1,
                            icon: Icon(
                              Icons.add,
                              color: Colours.blue.code,
                            ),
                            paddingHorizontal: 30.0,
                            paddingVertical: 20.0),
                        grayContainer(text: AppConstants.imageText1, icon: Icon(Icons.add, color: Colours.blue.code), paddingHorizontal: 30.0, paddingVertical: 20.0),
                        grayContainer(text: AppConstants.imageText1, icon: Icon(Icons.add, color: Colours.blue.code), paddingHorizontal: 30.0, paddingVertical: 20.0)
                      ],
                    ),
                    verticalSpacer(),
                    GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => const HomeTabs()));
                        },
                        child: appButton(bkColor: Colours.blue.code, text: AppConstants.saveText))
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
