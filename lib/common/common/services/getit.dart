import 'package:get_it/get_it.dart';

import 'NavigationService.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => NavigationService());
}
