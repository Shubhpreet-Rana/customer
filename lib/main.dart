import 'package:app/bloc/booking/booking_bloc.dart';
import 'package:app/bloc/home/home_bloc.dart';
import 'package:app/bloc/home/view_cars/view_car_bloc.dart';
import 'package:app/bloc/payment/payment_bloc.dart';
import 'package:app/bloc/payment/payment_repository/payment_repository.dart';
import 'package:app/bloc/serviceProvider/service_provider_bloc.dart';
import 'package:app/bloc/vehicle/add/add_vehicle_bloc.dart';
import 'package:app/common/methods/common.dart';
import 'package:app/data/repository/add_vehicle_repository.dart';
import 'package:app/data/repository/booking_repository.dart';
import 'package:app/data/repository/home_repository.dart';
import 'package:app/data/repository/profile_repository.dart';
import 'package:app/data/repository/service_provider_repository.dart';
import 'package:app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/home/add_car/add_car_bloc.dart';
import 'bloc/profile/create/create_profile_bloc.dart';
import 'bloc/profile/view/profile_bloc.dart';
import 'bloc/vehicle/view/vehicle_bloc.dart';
import 'common/constants.dart';
import 'common/methods/custom_storage.dart';
import 'common/services/NavigationService.dart';
import 'common/services/getit.dart';
import 'data/repository/auth_repository.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_IeMh5jJQLbz2oSewCue5ig4M00heVbG5tF";
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
        RepositoryProvider<VehicleRepository>(
          create: (context) => VehicleRepository(),
        ),
        RepositoryProvider<ServiceProviderRepository>(
          create: (context) => ServiceProviderRepository(),
        ),
        RepositoryProvider<HomeRepository>(
          create: (context) => HomeRepository(),
        ),
        RepositoryProvider<BookingRepository>(
          create: (context) => BookingRepository(),
        ),
        RepositoryProvider<PaymentRepository>(
          create: (context) => PaymentRepository(),
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
              addVehicleRepository: RepositoryProvider.of<VehicleRepository>(context),
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              profileRepository: RepositoryProvider.of<ProfileRepository>(context),
            ),
          ),
          BlocProvider<VehicleBloc>(
            create: (context) => VehicleBloc(
              vehicleRepository: RepositoryProvider.of<VehicleRepository>(context),
            ),
          ),
          BlocProvider<ServiceProviderBloc>(
              create: (context) => ServiceProviderBloc(
                    serviceProviderRepository: RepositoryProvider.of<ServiceProviderRepository>(context),
                  )),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              homeRepository: RepositoryProvider.of<HomeRepository>(context),
            ),
          ),
          BlocProvider<BookingBloc>(
            create: (context) => BookingBloc(
              bookingRepository: RepositoryProvider.of<BookingRepository>(context),
            ),
          ),
          BlocProvider<ViewCarBloc>(
            create: (context) => ViewCarBloc(
              homeRepository: RepositoryProvider.of<HomeRepository>(context),
            ),
          ),
          BlocProvider<SellCarBloc>(
            create: (context) => SellCarBloc(
              homeRepository: RepositoryProvider.of<HomeRepository>(context),
            ),
          ),
          BlocProvider<PaymentBloc>(
            create: (context) => PaymentBloc(
              paymentReository: RepositoryProvider.of<PaymentRepository>(context),
            ),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: locator<NavigationService>().navigatorKey,
          title: AppConstants.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Splash(),
        ),
      ),
    );
  }
}
