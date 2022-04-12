import 'package:app/common/constants.dart';
import 'package:app/common/methods/common.dart';
import 'package:app/common/styles/styles.dart';
import 'package:app/common/ui/headers.dart';
import 'package:app/screens/registration/forgot_password.dart';
import 'package:app/screens/registration/profile_setup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../common/assets.dart';
import '../../common/colors.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/edit_text.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(bottom: false, child: AppHeaders().extendedHeader(text: AppConstants.signUp2, context: context)),
            verticalSpacer(
              height: 60.0,
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
                      /*  MyEditText(AppConstants.nameHint, false, TextInputType.text, TextCapitalization.none, 10.0, nameController, Colours.hintColor.code, true),
                      const SizedBox(
                        height: 20.0,
                      ),*/
                      MyEditText(AppConstants.emailHint, false, TextInputType.emailAddress, TextCapitalization.none, 10.0, emailController, Colours.hintColor.code, true),
                      verticalSpacer(),
                      /* MyEditText(AppConstants.mobileHint, false, TextInputType.phone, TextCapitalization.none, 10.0, mobileController, Colours.hintColor.code, true),
                      const SizedBox(
                        height: 20.0,
                      ),*/
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
                      GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => const ProfileSetUp()));
                          },
                          child: appButton(bkColor: Colours.blue.code, text: AppConstants.signUp)),
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
                              TextSpan(text: AppConstants.doAccount + " ", style: AppStyles.blackText),
                              TextSpan(
                                text: AppConstants.signIn,
                                style: AppStyles.blackBlue,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pop();
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
}
