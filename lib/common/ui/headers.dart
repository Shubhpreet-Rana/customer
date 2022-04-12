import 'package:app/common/styles/styles.dart';
import 'package:flutter/material.dart';

class AppHeaders {
  Widget extendedHeader({bool backNavigation = true, required BuildContext context, required String text}) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (backNavigation)
             Padding(
              padding: const EdgeInsets.only(left: 30.0,top: 15.0),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: ()=>Navigator.of(context).pop(),
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
}
