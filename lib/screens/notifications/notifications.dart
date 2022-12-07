import 'package:app/common/assets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/styles/styles.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/headers.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(bottom: false, child: AppHeaders().collapsedHeader(text: AppConstants.notifications, context: context, backNavigation: true, onFilterClick: () {})),
          verticalSpacer(),
          Expanded(
              child: Container(
            width: CommonMethods.deviceWidth(),
            height: CommonMethods.deviceHeight(),
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0, top: 20.0),
            decoration: BoxDecoration(
              color: Colours.lightGray.code,
            ),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return listItem(avatar: Assets.userJames.name, name: "James", msg: "is interested in your", type: "post", time: "5 min ago");
                    }
                    if (index == 1) {
                      return listItem(avatar: Assets.userMerry.name, name: "Merry", msg: "posted a new", type: "post", time: "15 min ago");
                    }
                    if (index == 2) {
                      return listItem(avatar: Assets.userPeter.name, name: "Peter", msg: "is interested in your", type: "post", time: "2 days ago");
                    } else {
                      return listItem(avatar: Assets.userDanish.name, name: "Danish", msg: "posted a new", type: "post", time: "5 days ago");
                    }
                  }),
            ),
          ))
        ],
      )),
    );
  }

  Widget listItem({required String avatar, required String name, required String msg, required String type, required String time}) => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colours.darkGray.code,
              radius: 30.0,
              backgroundImage: AssetImage(avatar),
            ),
            horizontalSpacer(width: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(text: "$name ", style: AppStyles.blackBold),
                      TextSpan(
                        text: "$msg ",
                        style: AppStyles.lightText,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      TextSpan(
                        text: "$type.",
                        style: AppStyles.blackBold,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
                Text(
                  "$time ",
                  style: AppStyles.lightText,
                ),
              ],
            )
          ],
        ),
      );
}
