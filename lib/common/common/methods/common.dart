
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../../screens/filters/filters.dart';
import '../../../screens/notifications/notifications.dart';
import '../services/NavigationService.dart';

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
}
