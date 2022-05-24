import 'dart:io';

import 'package:app/common/colors.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../assets.dart';

class Avatar extends StatelessWidget {
  final double radius;
  final bool isCamera;
  final String imagePath;
  final Function onSelect;
  final bool isFile;
  final bool fromUrl;

  const Avatar(
      {Key? key,
      this.radius = 35.0,
      this.isCamera = false,
      this.imagePath = "",
      required this.onSelect,
      this.isFile = false,
      this.fromUrl = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      imagePath == ""
          ? CircleAvatar(
              backgroundColor: Colours.darkGray.code,
              radius: radius,
            )
          : CircleAvatar(
              backgroundColor: Colours.darkGray.code,
              radius: radius,
              backgroundImage: fromUrl
                  ? ExtendedNetworkImageProvider(imagePath, retries: 3, cache: true)
                  : isFile
                      ? Image.file(File(imagePath)).image
                      : AssetImage(imagePath),
            ),
      if (isCamera)
        Positioned(
            right: 4,
            bottom: 0,
            child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  onSelect();
                },
                child: SvgPicture.asset(Assets.camera.name)))
    ]);
  }
}
