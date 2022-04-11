import 'package:app/common/services/NavigationService.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => NavigationService());
}
