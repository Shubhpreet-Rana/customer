import 'package:app/common/styles/styles.dart';
import 'package:flutter/material.dart';

class AppHeaders {
  Widget extendedHeader({bool backNavigation = true, required String text}) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (backNavigation)
            const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
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
