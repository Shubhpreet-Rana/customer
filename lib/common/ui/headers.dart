import 'package:app/common/assets.dart';
import 'package:app/common/styles/styles.dart';
import 'package:app/common/ui/common_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppHeaders {
  Widget extendedHeader({bool backNavigation = true, required BuildContext context, required String text}) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (backNavigation)
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 15.0),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => Navigator.of(context).pop(),
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

  Widget collapsedHeader({bool backNavigation = true, required BuildContext context, String text = "", bool filterIcon = true, bool menuIcon = true, Function()? onFilterClick, Function()? onMenuClick}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 10.0),
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
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    text,
                    style: AppStyles.buttonText,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0, top: 15.0),
            child: Row(
              children: [
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      onFilterClick!();
                    },
                    child: SvgPicture.asset(Assets.filters.name)),
                horizontalSpacer(),
                SvgPicture.asset(Assets.menu.name),
              ],
            ),
          )
        ],
      );
}
