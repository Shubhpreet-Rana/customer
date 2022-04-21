
import 'package:flutter/material.dart';

import '../assets.dart';
import '../methods/common.dart';

class BackgroundImage extends StatelessWidget {
  final bool withLogo;
  final Widget child;

  const BackgroundImage({Key? key, this.withLogo = false, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CommonMethods.deviceHeight(),
      width: CommonMethods.deviceWidth(),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(withLogo ? Assets.splashPng.name : Assets.backImage.name),
        fit: BoxFit.cover,
      )),
      child: child,
    );
  }
}
