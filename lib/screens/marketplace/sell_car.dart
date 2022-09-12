import 'package:app/bloc/home/add_car/add_car_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  const SellCar({Key? key, this.fromEdit = false}) : super(key: key);

  @override
  State<SellCar> createState() => _SellCarState();
}

class _SellCarState extends State<SellCar> {
  TextEditingController brandNameController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String selectedColor = "";
  String mileage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(const Duration(days: 7305)),
        lastDate: DateTime.now());
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
            SafeArea(
                bottom: false,
                child: AppHeaders().extendedHeader(
                    text: AppConstants.vehicle, context: context)),
            verticalSpacer(
              height: 10.0,
            ),
            Expanded(
                child: Container(
              width: CommonMethods.deviceWidth(),
              height: CommonMethods.deviceHeight(),
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, bottom: 5.0, top: 40.0),
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
                        brandNameController,
                        Colours.hintColor.code,
                        true),
                    verticalSpacer(),
                    headingText(text: AppConstants.modelText),
                    verticalSpacer(height: 10.0),
                    MyEditText(
                        AppConstants.modelText,
                        false,
                        TextInputType.text,
                        TextCapitalization.none,
                        10.0,
                        modelController,
                        Colours.hintColor.code,
                        true),
                    verticalSpacer(),
                    headingText(text: AppConstants.engineText),
                    verticalSpacer(height: 10.0),
                    MyEditText(
                        AppConstants.engineText,
                        false,
                        TextInputType.text,
                        TextCapitalization.none,
                        10.0,
                        engineController,
                        Colours.hintColor.code,
                        true),
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
                    MyEditText(
                        r"$",
                        false,
                        TextInputType.number,
                        TextCapitalization.none,
                        10.0,
                        priceController,
                        Colours.hintColor.code,
                        true),
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
                            paddingHorizontal: 15.0,
                            paddingVertical: 15.0),
                        grayContainer(
                            text: AppConstants.imageText1,
                            icon: Icon(Icons.add, color: Colours.blue.code),
                            paddingHorizontal: 15.0,
                            paddingVertical: 15.0),
                        grayContainer(
                            text: AppConstants.imageText1,
                            icon: Icon(Icons.add, color: Colours.blue.code),
                            paddingHorizontal: 15.0,
                            paddingVertical: 15.0)
                      ],
                    ),
                    verticalSpacer(),
                    BlocBuilder<SellCarBloc, AddCarToSellState>(
                        builder: (context, state) {
                      if (state is Loading) {
                        return Container(
                          width: CommonMethods.deviceWidth(),
                          height: 55,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            if (!widget.fromEdit) {
                              BlocProvider.of<SellCarBloc>(context).add(
                                  AddCarToSell(
                                      brand_name: brandNameController.text,
                                      model_name: modelController.text,
                                      capacity: engineController.text,
                                      color: selectedColor,
                                      description: descriptionController.text,
                                      mileage: AppConstants.mileageText,
                                      manufacturing_year: mileage,
                                      address: "",
                                  ));
                            }
                            if (widget.fromEdit) Navigator.pop(context);
                            //Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => const HomeTabs()));
                          },
                          child: appButton(
                              bkColor: Colours.blue.code,
                              text: widget.fromEdit
                                  ? AppConstants.update
                                  : AppConstants.addCar));
                    }),
                    verticalSpacer(height: 120),
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
