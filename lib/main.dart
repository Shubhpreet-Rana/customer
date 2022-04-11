import 'package:app/common/methods/common.dart';
import 'package:app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'common/constants.dart';
import 'common/methods/custom_storage.dart';
import 'common/services/NavigationService.dart';
import 'common/services/getit.dart';

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  CommonMethods.init();
  PreferenceUtils.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final GetIt locator = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: locator<NavigationService>().navigatorKey,
      title: AppConstants.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
    );
  }
}
