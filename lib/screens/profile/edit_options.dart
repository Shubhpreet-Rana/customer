import 'package:app/common/methods/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/headers.dart';
import '../registration/profile_setup.dart';
import '../vehicle/edit_vehicle.dart';


class EditOptions extends StatefulWidget {
  const EditOptions({Key? key}) : super(key: key);

  @override
  State<EditOptions> createState() => _EditOptionsState();
}

class _EditOptionsState extends State<EditOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(bottom: false, child: AppHeaders().collapsedHeader(text: AppConstants.editProfile, context: context, backNavigation: true, filterIcon: false)),
          verticalSpacer(),
          Expanded(
            child: Container(
              width: CommonMethods.deviceWidth(),
              height: CommonMethods.deviceHeight(),
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 5.0, top: 40.0),
              decoration: BoxDecoration(
                color: Colours.lightGray.code,
              ),
              child: Column(
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
                            builder: (context) => const ProfileSetUpScreen(
                                  fromEdit: true,
                                )));
                      },
                      child: appButton(bkColor: Colours.blue.code, text: AppConstants.myProfileDetails, height: 50.0)),
                  verticalSpacer(),
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
                            builder: (context) => const EditVehicle(
                                )));
                      },
                      child: appButton(bkColor: Colours.blue.code, text: AppConstants.myCarDetails, height: 50.0)),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
