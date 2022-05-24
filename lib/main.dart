import 'package:app/bloc/vehicle/add/add_vehicle_bloc.dart';
import 'package:app/common/methods/common.dart';
import 'package:app/data/repository/add_vehicle_repository.dart';
import 'package:app/data/repository/profile_repository.dart';
import 'package:app/screens/registration/profile_setup.dart';
import 'package:app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/profile/create/create_profile_bloc.dart';
import 'bloc/profile/view/profile_bloc.dart';
import 'common/constants.dart';
import 'common/methods/custom_storage.dart';
import 'common/services/NavigationService.dart';
import 'common/services/getit.dart';
import 'data/repository/auth_repository.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(),
        ),
        RepositoryProvider<AddVehicleRepository>(
          create: (context) => AddVehicleRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider<CreateProfileBloc>(
            create: (context) => CreateProfileBloc(
              profileRepository: RepositoryProvider.of<ProfileRepository>(context),
            ),
          ),
          BlocProvider<AddVehicleBloc>(
            create: (context) => AddVehicleBloc(
              addVehicleRepository: RepositoryProvider.of<AddVehicleRepository>(context),
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              profileRepository: RepositoryProvider.of<ProfileRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          navigatorKey: locator<NavigationService>().navigatorKey,
          title: AppConstants.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Splash(),
          // home: const ProfileSetUp(),
        ),
      ),
    );
  }
}
