import 'package:app/common/services/NavigationService.dart';
import 'package:app/screens/notifications/notifications.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../screens/filters/filters.dart';
import '../colors.dart';

class CommonMethods {
  static GetIt? _locator;

  static Future<GetIt> get _instance async => _locator ??= GetIt.instance;

  static Future<GetIt> init() async {
    _locator = await _instance;
    return _locator!;
  }

  static BuildContext currentContext() => _locator!<NavigationService>().navigatorKey.currentContext!;

  static double deviceHeight() => MediaQuery.of(currentContext()).size.height;

  static double deviceWidth() => MediaQuery.of(currentContext()).size.width;

  openFilters(BuildContext context) {
    Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(builder: (context) => const ApplyFilters()));
  }

  openNotifications(BuildContext context) {
    Navigator.of(context, rootNavigator: false).push(CupertinoPageRoute(builder: (context) => const Notifications()));
  }

  void showTopFlash({required BuildContext context, String title = "Error!", required String message, String btnText = "DISMISS", FlashBehavior style = FlashBehavior.floating}) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 4),
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          boxShadows: const [BoxShadow(blurRadius: 4)],
          barrierBlur: 3.0,
          barrierColor: Colors.black38,
          barrierDismissible: true,
          behavior: style,
          position: FlashPosition.top,
          child: FlashBar(
            title: Text(title, style: TextStyle(color: Colours.red.code, fontSize: 20.0)),
            content: Text(message, style: const TextStyle(color: Colors.black, fontSize: 16.0)),
            showProgressIndicator: false,
            primaryAction: TextButton(
              onPressed: () => controller.dismiss(),
              child: Text(btnText, style: TextStyle(color: Colours.red.code)),
            ),
          ),
        );
      },
    );
  }
}
