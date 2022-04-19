import 'package:app/common/assets.dart';
import 'package:app/common/constants.dart';
import 'package:flutter/material.dart';

import '../../../common/colors.dart';
import '../../../common/methods/common.dart';
import '../../../common/styles/styles.dart';
import '../../../common/ui/avatar.dart';
import '../../../common/ui/background.dart';
import '../../../common/ui/common_ui.dart';
import '../../../common/ui/headers.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
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
            child: Column(
              children: [
                Avatar(
                  radius: 50.0,
                  isCamera: true,
                  imagePath: Assets.userPeter1.name,
                ),
                verticalSpacer(height: 30.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        AppConstants.fNameHint,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: AppStyles.lightText,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        "Peter",
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        style: AppStyles.blackSemiW400_1,
                      ),
                    )
                  ],
                ),
                verticalSpacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        AppConstants.lNameHint,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: AppStyles.lightText,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        "Smith",
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: AppStyles.blackSemiW400_1,
                      ),
                    )
                  ],
                ),
                verticalSpacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        AppConstants.emailHint,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: AppStyles.lightText,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        "petersmith@gmail.com",
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        style: AppStyles.blackSemiW400_1,
                      ),
                    )
                  ],
                ),
                verticalSpacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        AppConstants.mobileHint,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: AppStyles.lightText,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        "+1 123-456-7890",
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: AppStyles.blackSemiW400_1,
                      ),
                    )
                  ],
                ),
                verticalSpacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        AppConstants.genderHint,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: AppStyles.lightText,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        "Male",
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: AppStyles.blackSemiW400_1,
                      ),
                    )
                  ],
                ),
                verticalSpacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        AppConstants.addressHint,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style: AppStyles.lightText,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        "Smi36 China town, Down street, California",
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        style: AppStyles.blackSemiW400_1,
                      ),
                    )
                  ],
                ),
                //verticalSpacer(height: 50.0),
                const Spacer(),
                appButton(bkColor: Colours.blue.code, text: AppConstants.edit, height: 50.0),
                verticalSpacer(),
                Text(
                  AppConstants.logout,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  style: AppStyles.redTextW500,
                ),
                const Spacer(),
              ],
            ),
          ))
        ],
      )),
    );
  }
}
