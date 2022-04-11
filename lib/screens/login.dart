import 'package:app/common/constants.dart';
import 'package:app/common/methods/common.dart';
import 'package:app/common/styles/styles.dart';
import 'package:app/common/ui/headers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../common/assets.dart';
import '../common/colors.dart';
import '../common/ui/background.dart';
import '../common/ui/button.dart';
import '../common/ui/edit_text.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool show = true;
  bool rememberMe = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Stack(
          children: [
            SafeArea(child: AppHeaders().extendedHeader(text: AppConstants.login, backNavigation: false)),
            Positioned(
              top: 200.0,
              left: 0.0,
              child: Container(
                width: CommonMethods.deviceWidth(),
                height: CommonMethods.deviceHeight(),
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(33),
                    topRight: Radius.circular(33),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.welcome,
                      style: AppStyles.darkText,
                    ),
                    Text(
                      AppConstants.loginMsg,
                      style: AppStyles.lightText,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    MyEditText(AppConstants.emailHint, false, TextInputType.emailAddress, TextCapitalization.none, 10.0, emailController, Colours.hintColor.code, true),
                    const SizedBox(
                      height: 20.0,
                    ),
                    MyEditText(
                      AppConstants.passwordHint,
                      true,
                      TextInputType.text,
                      TextCapitalization.none,
                      10.0,
                      passwordController,
                      Colours.hintColor.code,
                      true,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: Checkbox(value: rememberMe, checkColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), onChanged: _onRememberMeChanged),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          AppConstants.stayLogin,
                          style: AppStyles.blackText,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    appButton(bkColor: Colours.blue.code, text: AppConstants.login1),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(text: AppConstants.forgotPwd + " ", style: AppStyles.blackText),
                            TextSpan(
                              text: AppConstants.recover,
                              style: AppStyles.blackBlue,
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    socialButton(bkColor: Colours.darkBlue.code, text: AppConstants.fb, icon: Assets.fb.name),
                    const SizedBox(
                      height: 20.0,
                    ),
                    socialButton(bkColor: Colours.red.code, text: AppConstants.google, icon: Assets.google.name),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(text: AppConstants.dontAccount + " ", style: AppStyles.blackText),
                            TextSpan(
                              text: AppConstants.signUp1,
                              style: AppStyles.blackBlue,
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onRememberMeChanged(bool? newValue) => setState(() {
        rememberMe = newValue!;
        if (mounted) {
          setState(() {});
        }
      });
}
