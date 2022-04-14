import 'package:flutter/material.dart';

enum Colours {
  lightGray,
  blue,
  red,
  darkBlue,
  hintColor,
  textBlack,
  darkGray,
  lightBlue,
  unSelectTab,
  gray,
  green,
  lightWhite
}

extension ColourCode on Colours {
  Color get code {
    switch (this) {
      case Colours.lightGray:
        return const Color(0xFFF4F4F4);
      case Colours.blue:
        return const Color(0xFF1E7BE2);
      case Colours.darkBlue:
        return const Color(0xFF3A54A0);
      case Colours.red:
        return const Color(0xFFEB2F2A);
      case Colours.hintColor:
        return const Color(0xFF666666);
      case Colours.textBlack:
        return const Color(0xFF333333);
      case Colours.darkGray:
        return const Color(0xFFC4C4C4);
      case Colours.lightBlue:
        return const Color(0xFF93B9E2);
      case Colours.unSelectTab:
        return const Color(0xFF999999);
      case Colours.gray:
        return const Color(0xFFBDBDBD);
      case Colours.green:
        return const Color(0xFF43B71B);
      case Colours.lightWhite:
        return const Color(0xFFF5F5F5);
      default:
        return const Color(0xFF000000);
    }
  }
}
