import 'package:app/common/colors.dart';
import 'package:app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../methods/common.dart';
import '../styles/styles.dart';

Widget appButton({required Color? bkColor, String text = '',double height =55.0}) => Container(
      width: CommonMethods.deviceWidth(),
      height: height,
      decoration: BoxDecoration(color: bkColor, borderRadius: BorderRadius.circular(10.0)),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppStyles.buttonText,
        ),
      ),
    );

Widget rowButton(
        {required Color? bkColor,
        String text = '',
        double paddingHorizontal = 10.0,
        double paddingVertical = 15.0,
        Color textColor = Colors.white}) =>
    Container(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      decoration: BoxDecoration(color: bkColor, borderRadius: BorderRadius.circular(10.0)),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: textColor, fontWeight: FontWeight.w500),
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
        required TextEditingController controller,
        String hintText = "search"}) =>
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
            decoration: InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: hintText,
            ),
          ))
        ],
      ),
    );

Widget ratingBar({bool isSelected = false, String position = "5"}) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: isSelected ? Colours.blue.code : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: isSelected ? Colors.white : Colours.blue.code,
          ),
          horizontalSpacer(width: 2.0),
          Text(
            position.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          )
        ],
      ),
    );
