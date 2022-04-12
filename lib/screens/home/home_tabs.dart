import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/headers.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({Key? key}) : super(key: key);

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundImage(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(bottom: false, child: AppHeaders().extendedHeader(text: AppConstants.vehicle, context: context, backNavigation: false)),
        verticalSpacer(
          height: 10.0,
        ),
      ],
    )));
  }
}
