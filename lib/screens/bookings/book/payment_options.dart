import 'package:app/common/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/assets.dart';
import '../../../common/colors.dart';
import '../../../common/constants.dart';
import '../../../common/methods/common.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/headers.dart';

class PaymentOptions extends StatefulWidget {
  final double totalPayment;

  const PaymentOptions({Key? key, required this.totalPayment}) : super(key: key);

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
              bottom: false,
              child: AppHeaders()
                  .collapsedHeader(text: AppConstants.payOptions, context: context, backNavigation: true, onFilterClick: () {})),
          verticalSpacer(),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              width: CommonMethods.deviceWidth(),
              height: CommonMethods.deviceHeight(),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0, top: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: CommonMethods.deviceWidth(),
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    decoration: BoxDecoration(color: Colours.lightGray.code, borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      r"$" + widget.totalPayment.toString(),
                      style: AppStyles.darkText14,
                    ),
                  ),
                  verticalSpacer(),
                  Container(
                    width: CommonMethods.deviceWidth(),
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                    decoration: BoxDecoration(color: Colours.blue.code, borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConstants.holderName,
                          style: AppStyles.whiteTextW500,
                        ),
                        verticalSpacer(height: 10.0),
                        const Text(
                          "Peter Smith",
                          style: AppStyles.buttonText,
                        ),
                        verticalSpacer(),
                        Text(
                          AppConstants.cardNumberHint,
                          style: AppStyles.whiteTextW500,
                        ),
                        verticalSpacer(height: 10.0),
                        const Text(
                          "XXXX - XXXX - XXXX - XXXX",
                          style: AppStyles.buttonText,
                        ),
                        verticalSpacer(),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                AppConstants.cardExpDateHint,
                                style: AppStyles.whiteTextW500,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                AppConstants.cardCvvHint,
                                style: AppStyles.whiteTextW500,
                              ),
                            ),
                          ],
                        ),
                        verticalSpacer(height: 5.0),
                        Row(
                          children: const [
                            Expanded(
                              flex: 4,
                              child: Text(
                                "25 Mar, 2025",
                                style: AppStyles.buttonText,
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                "255",
                                style: AppStyles.buttonText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpacer(height: 30.0),
                  Text(AppConstants.newPayment, style: AppStyles.blackSemiBold),
                  verticalSpacer(height: 30.0),
                  paymentOptions(icon: Assets.card.name, text: AppConstants.paymentItems[2]),
                  Container(
                    height: 1.5,
                    color: Colours.hintColor.code,
                  ),
                  paymentOptions(icon: Assets.card.name, text: AppConstants.paymentItems[1]),
                  Container(
                    height: 1.5,
                    color: Colours.hintColor.code,
                  ),
                  paymentOptions(icon: Assets.bank.name, text: AppConstants.paymentItems[0]),
                  Container(
                    height: 1.5,
                    color: Colours.hintColor.code,
                  ),
                  verticalSpacer(height: 30.0),
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        /* Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
                            builder: (context) => PaymentOptions(
                              totalPayment: getTotal(),
                            )));*/
                      },
                      child: appButton(bkColor: Colours.blue.code, text: AppConstants.payNow, height: 50.0)),
                  verticalSpacer(height: 5.0),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }

  Widget paymentOptions({required String icon, required String text}) => Padding(
        padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    width: 30.0,
                    child: SvgPicture.asset(
                      icon,
                      fit: BoxFit.contain,
                    )),
                horizontalSpacer(),
                Text(
                  text,
                  style: AppStyles.blackSemiW400,
                )
              ],
            ),
            Icon(Icons.add)
          ],
        ),
      );
}
