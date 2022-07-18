import 'package:app/bloc/profile/view/profile_bloc.dart';
import 'package:app/common/constants.dart';
import 'package:app/common/methods/custom_storage.dart';
import 'package:app/screens/home/home_tabs.dart';
import 'package:app/screens/registration/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../common/ui/background.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToNext();
  }

  goToNext() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    bool? isAlreadyLogin =
        await PreferenceUtils.getBool(AppConstants.rememberMe);
    if (isAlreadyLogin) {
      context.read<ProfileBloc>().add(ProfileFetchEvent());
      Navigator.of(context, rootNavigator: true).pushReplacement(
          CupertinoPageRoute(builder: (context) => const HomeTabs()));
    } else {
      Navigator.of(context, rootNavigator: true)
          .pushReplacement(CupertinoPageRoute(
        builder: (context) => const Login(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: BackgroundImage(
      withLogo: true,
      child: SizedBox.shrink(),
    ));
  }
}
