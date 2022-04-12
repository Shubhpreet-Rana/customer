import 'package:app/common/constants.dart';
import 'package:app/common/methods/common.dart';
import 'package:app/common/styles/styles.dart';
import 'package:app/common/ui/headers.dart';
import 'package:app/screens/registration/forgot_password.dart';
import 'package:app/screens/registration/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../common/assets.dart';
import '../../common/colors.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/edit_text.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool show = true;
  bool rememberMe = true;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(child: AppHeaders().extendedHeader(text: AppConstants.login, context: context, backNavigation: false)),
            verticalSpacer(
              height: 100.0,
            ),
            Expanded(
              child: Container(
                width: CommonMethods.deviceWidth(),
                height: CommonMethods.deviceHeight(),
                padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 5.0, top: 40.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(33),
                    topRight: Radius.circular(33),
                  ),
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                child: SingleChildScrollView(
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
                      verticalSpacer(
                        height: 30.0,
                      ),
                      MyEditText(AppConstants.emailHint, false, TextInputType.emailAddress, TextCapitalization.none, 10.0, emailController, Colours.hintColor.code, true),
                      verticalSpacer(),
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
                      verticalSpacer(),
                      Row(
                        children: [
                          SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: Checkbox(value: rememberMe, checkColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), onChanged: _onRememberMeChanged),
                          ),
                          horizontalSpacer(
                            width: 10.0,
                          ),
                          Text(
                            AppConstants.stayLogin,
                            style: AppStyles.blackText,
                          ),
                        ],
                      ),
                      verticalSpacer(),
                      appButton(bkColor: Colours.blue.code, text: AppConstants.login1),
                      verticalSpacer(),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(text: AppConstants.forgotPwd + " ", style: AppStyles.blackText),
                              TextSpan(
                                text: AppConstants.recover,
                                style: AppStyles.blackBlue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
                                      builder: (context) => const ForgotPassword(),
                                    ));
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpacer(
                        height: 40.0,
                      ),
                      socialButton(bkColor: Colours.darkBlue.code, text: AppConstants.fb, icon: Assets.fb.name),
                      verticalSpacer(),
                      socialButton(bkColor: Colours.red.code, text: AppConstants.google, icon: Assets.google.name),
                      verticalSpacer(
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
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => const SignUp()));
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpacer(),
                    ],
                  ),
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
