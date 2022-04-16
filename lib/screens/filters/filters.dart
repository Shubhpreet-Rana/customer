import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/styles/styles.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/headers.dart';

class ApplyFilters extends StatefulWidget {
  const ApplyFilters({Key? key}) : super(key: key);

  @override
  State<ApplyFilters> createState() => _ApplyFiltersState();
}

class _ApplyFiltersState extends State<ApplyFilters> {
  int _radioValue1 = 1;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }

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
          SafeArea(bottom: false, child: AppHeaders().extendedHeader(text: AppConstants.filters, context: context)),
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
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      Row(
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: Radio(
                              value: 1,
                              groupValue: _radioValue1,
                              onChanged: (int? value) {
                                if (value != null) {
                                  setState(() {
                                    _handleRadioValueChange1(value);
                                  });
                                }
                              },
                            ),
                          ),
                          horizontalSpacer(width: 10.0),
                          const Text('Car Wash'),
                        ],
                      ),
                      verticalSpacer(height: 10.0),
                      Row(
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: Radio(
                              value: 2,
                              groupValue: _radioValue1,
                              onChanged: (int? value) {
                                if (value != null) {
                                  setState(() {
                                    _handleRadioValueChange1(value);
                                  });
                                }
                              },
                            ),
                          ),
                          horizontalSpacer(width: 10.0),
                          const Text('Oil Change'),
                        ],
                      ),
                      verticalSpacer(height: 10.0),
                      Row(
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: Radio(
                              value: 3,
                              groupValue: _radioValue1,
                              onChanged: (int? value) {
                                if (value != null) {
                                  setState(() {
                                    _handleRadioValueChange1(value);
                                  });
                                }
                              },
                            ),
                          ),
                          horizontalSpacer(width: 10.0),
                          const Text('Pick and Drop'),
                        ],
                      ),
                      verticalSpacer(),
                      Text(
                        AppConstants.ratings,
                        style: AppStyles.blackSemiBold,
                      ),
                      verticalSpacer(height: 10.0),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(height: 58.0, child: ratingBar()),
                )
              ],
            )),
          ))
        ],
      )),
    );
  }
}
