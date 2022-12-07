import 'package:app/bloc/booking/booking_bloc.dart';
import 'package:app/bloc/card%20/add_card/add_card_bloc.dart';
import 'package:app/bloc/card%20/get_card/get_card_bloc.dart';
import 'package:app/bloc/charge_user/charge_user_bloc.dart';
import 'package:app/bloc/delete_my_marketplace_vehicle/delete_my_marketplace_vehicle_bloc.dart';
import 'package:app/bloc/feedback/feedback_bloc.dart';
import 'package:app/bloc/home/get_category_list/get_category_list_bloc.dart';
import 'package:app/bloc/home/home_bloc.dart';
import 'package:app/bloc/home/view_cars/view_car_bloc.dart';
import 'package:app/bloc/payment/payment_bloc.dart';
import 'package:app/bloc/serviceProvider/service_provider_bloc.dart';
import 'package:app/bloc/vehicle/add/add_vehicle_bloc.dart';
import 'package:app/common/methods/common.dart';
import 'package:app/data/repository/add_card_repository.dart';
import 'package:app/data/repository/add_feedback_repository.dart';
import 'package:app/data/repository/add_vehicle_repository.dart';
import 'package:app/data/repository/booking_repository.dart';
import 'package:app/data/repository/charge_user_repository.dart';
import 'package:app/data/repository/delete_my_markertplace_vehicle_repository.dart';
import 'package:app/data/repository/get_cards_repository.dart';
import 'package:app/data/repository/get_categoryList_repository.dart';
import 'package:app/data/repository/home_repository.dart';
import 'package:app/data/repository/profile_repository.dart';
import 'package:app/data/repository/service_provider_repository.dart';
import 'package:app/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/home/add_car/add_car_bloc.dart';
import 'bloc/mark_as_complete/mark_as_complete_bloc.dart';
import 'bloc/profile/create/create_profile_bloc.dart';
import 'bloc/profile/view/profile_bloc.dart';
import 'bloc/vehicle/view/vehicle_bloc.dart';
import 'common/constants.dart';
import 'common/methods/custom_storage.dart';
import 'common/notification_services/notifications_services.dart';
import 'common/services/NavigationService.dart';
import 'common/services/getit.dart';
import 'data/repository/auth_repository.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'data/repository/mark_as_cpmplete_repository.dart';
import 'data/repository/payment_repository.dart';

final GetIt locator = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await Firebase.initializeApp();
  Stripe.publishableKey = "pk_test_51L8Ss2Ih6nYkk6h8IbIjjTuoPTiFm8kdd470XPEtZuk7vQLLy06OaAerv8ZO7LQRhxNn8kCDFjdU4PDJRDZI7mj300TIhd4RZZ";
  Stripe.merchantIdentifier = "IN";
  CommonMethods.init();
  PreferenceUtils.init();
  NotificationServices.instance
    ..permissions
    ..setForegroundNotificationPresentationOptions
    ..getInitialMessage
    ..onMessage
    ..onMessageOpenedApp
    ..onBackgroundMessage;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _GetProviders._repositoryProvider,
      child: MultiBlocProvider(
        providers: _GetProviders._blocProvider,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: locator<NavigationService>().navigatorKey,
          title: AppConstants.appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}

class _GetProviders {
  _GetProviders._private();

  static final List<RepositoryProvider> _repositoryProvider = <RepositoryProvider>[
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
    RepositoryProvider<GetCardRepository>(
      create: (context) => GetCardRepository(),
    ),
    RepositoryProvider<ChargeUserRepository>(
      create: (context) => ChargeUserRepository(),
    ),
    RepositoryProvider<AddCardRepository>(
      create: (context) => AddCardRepository(),
    ),
    RepositoryProvider<GetCategoryListRepository>(
      create: (context) => GetCategoryListRepository(),
    ),
    RepositoryProvider<DeleteMyMarketPlaceVehicleRepository>(
      create: (context) => DeleteMyMarketPlaceVehicleRepository(),
    ),
    RepositoryProvider<AddFeedbackRepository>(
      create: (context) => AddFeedbackRepository(),
    ),
    RepositoryProvider<MarkAsCompleteRepository>(
      create: (context) => MarkAsCompleteRepository(),
    ),
  ];

  static final List<BlocProvider> _blocProvider = <BlocProvider>[
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        authRepository: RepositoryProvider.of<AuthRepository>(context),
      ),
    ),
    BlocProvider<SocialAuthBloc>(
      create: (context) => SocialAuthBloc(
        authRepository: RepositoryProvider.of<AuthRepository>(context),
      ),
    ),
    BlocProvider<CreateProfileBloc>(
      create: (context) => CreateProfileBloc(
        profileRepository: RepositoryProvider.of<ProfileRepository>(context),
      ),
    ),
    BlocProvider<MarkAsCompleteBloc>(
      create: (context) => MarkAsCompleteBloc(
        markAsCompleteRepository: RepositoryProvider.of<MarkAsCompleteRepository>(context),
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
    BlocProvider<AllVehicleBloc>(
      create: (context) => AllVehicleBloc(
        homeRepository: RepositoryProvider.of<HomeRepository>(context),
      ),
    ),
    BlocProvider<MyMarketVehicleBloc>(
      create: (context) => MyMarketVehicleBloc(
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
        paymentRepository: RepositoryProvider.of<PaymentRepository>(context),
      ),
    ),
    BlocProvider<GetCardBloc>(
      create: (context) => GetCardBloc(
        getCardRepository: RepositoryProvider.of<GetCardRepository>(context),
      ),
    ),
    BlocProvider<ChargeUserBloc>(
      create: (context) => ChargeUserBloc(
        chargeUserRepository: RepositoryProvider.of<ChargeUserRepository>(context),
      ),
    ),
    BlocProvider<AddCardBloc>(
      create: (context) => AddCardBloc(
        addCardRepository: RepositoryProvider.of<AddCardRepository>(context),
      ),
    ),
    BlocProvider<GetCategoryListBloc>(
      create: (context) => GetCategoryListBloc(
        getCategoryListRepository: RepositoryProvider.of<GetCategoryListRepository>(context),
      ),
    ),
    BlocProvider<DeleteMarketPlaceVehicleBloc>(
      create: (context) => DeleteMarketPlaceVehicleBloc(
        deleteMyMarketPlaceVehicleRepository: RepositoryProvider.of<DeleteMyMarketPlaceVehicleRepository>(context),
      ),
    ),
    BlocProvider<AddFeedbackBloc>(
      create: (context) => AddFeedbackBloc(
        addFeedbackRepository: RepositoryProvider.of<AddFeedbackRepository>(context),
      ),
    ),
  ];
}
