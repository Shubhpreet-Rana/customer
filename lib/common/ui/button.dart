import 'package:app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../methods/common.dart';
import '../styles/styles.dart';

Widget appButton({@required Color? bkColor, String text = ''}) => Container(
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

Widget socialButton({@required Color? bkColor, @required String? icon, String text = ''}) => Container(
      width: CommonMethods.deviceWidth(),
      height: 55.0,
      decoration: BoxDecoration(color: bkColor, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon!),
          const SizedBox(width: 10.0,),
          Text(
            text,
            textAlign: TextAlign.center,
            style: AppStyles.buttonText,
          ),
        ],
      ),
    );
