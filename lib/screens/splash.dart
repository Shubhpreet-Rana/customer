import 'package:app/screens/registration/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    Future.delayed(const Duration(milliseconds: 1000)).then((value) => Navigator.of(context, rootNavigator: true).pushReplacement(CupertinoPageRoute(
          builder: (context) => const Login(),
        )));
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
