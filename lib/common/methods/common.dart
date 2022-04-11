import 'package:app/common/services/NavigationService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
}
