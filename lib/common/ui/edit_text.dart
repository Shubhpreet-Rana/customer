import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';
import '../methods/call_back.dart';

class MyEditText extends StatelessWidget {
  final String hintText;
  final bool obscureValue;
  final TextInputType type;
  final TextCapitalization textCapital;
  final double paddingValue;
  final TextEditingController controllerName;
  final Color hintColor;
  final bool isEditable;
  final int? maxLine;
  final double? contentPadding;
  final IntCallback? iconClick;
  final TextInputAction textInputAction;
  final bool isSuffix;
  final Widget? suffixIcon;

  const MyEditText(this.hintText, this.obscureValue, this.type, this.textCapital, this.paddingValue, this.controllerName, this.hintColor, this.isEditable,
      {this.maxLine, this.contentPadding, this.iconClick, this.textInputAction = TextInputAction.next, this.isSuffix = false, this.suffixIcon});

  Widget getContainer({Widget? child}) {
    if (maxLine != null) {
      return Container(
        padding: EdgeInsets.all(paddingValue),
        decoration: BoxDecoration(color: Colours.lightGray.code, borderRadius: BorderRadius.circular(10.0)),
        child: child,
      );
    } else {
      return Container(
        padding: EdgeInsets.all(paddingValue),
        height: 55.0,
        decoration: BoxDecoration(color: Colours.lightGray.code, borderRadius: BorderRadius.circular(10.0)),
        child: child,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getContainer(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            obscureText: obscureValue,
            keyboardType: type,
            textInputAction: textInputAction,
            textCapitalization: textCapital,
            maxLines: maxLine ?? 1,
            enabled: isEditable,
            controller: controllerName,
            style: const TextStyle(color: Colors.black, fontSize: 18.0),
            cursorColor: Colours.blue.code,
            decoration: InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(color: hintColor, fontSize: 14.0, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        if (isSuffix) suffixIcon!
      ],
    ));
  }
}
