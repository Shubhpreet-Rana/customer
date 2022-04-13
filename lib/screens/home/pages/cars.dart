import 'package:flutter/material.dart';

import '../../../common/colors.dart';
import '../../../common/methods/common.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/headers.dart';

class CarTab extends StatefulWidget {
  const CarTab({Key? key}) : super(key: key);

  @override
  State<CarTab> createState() => _CarTabState();
}

class _CarTabState extends State<CarTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(bottom: false, child: AppHeaders().collapsedHeader(text: "", context: context, backNavigation: false, onFilterClick: () {})),
              verticalSpacer(
                height: 10.0,
              ),
              Expanded(
                  child: Container(
                    width: CommonMethods.deviceWidth(),
                    height: CommonMethods.deviceHeight(),
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 5.0, top: 40.0),
                    decoration: BoxDecoration(
                      color: Colours.lightGray.code,
                    ),
                  ))
            ],
          )),
    );
  }
}
