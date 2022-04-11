import 'package:flutter/material.dart';

enum Colours { lightGray, blue, red, darkBlue, hintColor, textBlack }

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
      default:
        return const Color(0xFF000000);
    }
  }
}
