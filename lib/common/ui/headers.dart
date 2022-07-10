import 'package:app/common/assets.dart';
import 'package:app/common/styles/styles.dart';
import 'package:app/common/ui/common_ui.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppHeaders {
  Widget extendedHeader(
          {GestureTapCallback? onTapped,
          bool backNavigation = true,
          required BuildContext context,
          required String text}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (backNavigation)
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 15.0),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: onTapped != null
                    ? onTapped
                    : () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 20.0),
            child: Text(
              text,
              style: AppStyles.appBarText,
            ),
          )
        ],
      );

  Widget collapsedHeader(
          {bool backNavigation = true,
          required BuildContext context,
          String text = "",
          bool filterIcon = true,
          bool menuIcon = true,
          Function()? onFilterClick,
          Function()? onNotificationClick}) =>
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Row(
          children: [
            backNavigation
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox.shrink(),
            horizontalSpacer(),
            Expanded(
              child: AutoSizeText(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                maxFontSize: 18.0,
                minFontSize: 12.0,
                style: AppStyles.buttonText,
              ),
            ),
            horizontalSpacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                filterIcon
                    ? GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (onFilterClick != null) onFilterClick();
                        },
                        child: SvgPicture.asset(Assets.filters.name))
                    : const SizedBox.shrink(),
                horizontalSpacer(),
                //SvgPicture.asset(Assets.menu.name),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (onNotificationClick != null) onNotificationClick();
                  },
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 25.0,
                  ),
                )
              ],
            )
          ],
        ),
      );
}
