import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../methods/common.dart';
import '../styles/styles.dart';

Widget appButton({required Color? bkColor, String text = ''}) => Container(
      width: CommonMethods.deviceWidth(),
      height: 55.0,
      decoration: BoxDecoration(color: bkColor, borderRadius: BorderRadius.circular(10.0)),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppStyles.buttonText,
        ),
      ),
    );

Widget rowButton({required Color? bkColor, String text = ''}) => Container(
      height: 55.0,
      decoration: BoxDecoration(color: bkColor, borderRadius: BorderRadius.circular(10.0)),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppStyles.whiteTextW500,
        ),
      ),
    );

Widget socialButton({required Color? bkColor, required String? icon, String text = ''}) => Container(
      width: CommonMethods.deviceWidth(),
      height: 55.0,
      decoration: BoxDecoration(color: bkColor, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon!),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: AppStyles.buttonText,
          ),
        ],
      ),
    );

Widget verticalSpacer({double height = 20.0}) => SizedBox(
      height: height,
    );

Widget horizontalSpacer({double width = 20.0}) => SizedBox(
      width: width,
    );

Widget headingText({String text = ""}) => Text(
      text,
      style: AppStyles.blackText,
    );

Widget grayContainer(
        {String text = '', required Widget icon, double paddingHorizontal = 10.0, double paddingVertical = 10.0, double bRadius = 10.0}) =>
    Container(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      decoration: BoxDecoration(color: Colours.lightGray.code, borderRadius: BorderRadius.circular(bRadius)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          Text(
            text,
            style: AppStyles.lightText,
          )
        ],
      ),
    );

Widget searchBox(
        {double paddingHorizontal = 10.0,
        double paddingVertical = 10.0,
        double borderRadius = 10.0,
        required TextEditingController controller}) =>
    Container(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(borderRadius)),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colours.gray.code,
          ),
          Expanded(
              child: TextFormField(
            textInputAction: TextInputAction.done,
            controller: controller,
            decoration: const InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: "search",
            ),
          ))
        ],
      ),
    );
