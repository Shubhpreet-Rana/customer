import 'package:flutter/material.dart';

import '../common/colors.dart';
import '../common/constants.dart';
import '../common/methods/common.dart';
import '../common/ui/background.dart';
import '../common/ui/button.dart';
import '../common/ui/edit_text.dart';
import '../common/ui/headers.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  bool show = true;

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
            SafeArea(child: AppHeaders().extendedHeader(text: AppConstants.forgotPwd1, context: context)),
            Positioned(
                top: 200.0,
                left: 0.0,
                child: Container(
                  width: CommonMethods.deviceWidth(),
                  height: CommonMethods.deviceHeight(),
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
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
                      MyEditText(
                        AppConstants.emailHint1,
                        false,
                        TextInputType.emailAddress,
                        TextCapitalization.none,
                        10.0,
                        emailController,
                        Colours.hintColor.code,
                        true,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      appButton(bkColor: Colours.blue.code, text: AppConstants.verifyHint),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
