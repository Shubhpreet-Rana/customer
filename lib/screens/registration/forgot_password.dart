import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../common/colors.dart';
import '../../common/constants.dart';
import '../../common/methods/common.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/edit_text.dart';
import '../../common/ui/headers.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController(text: kDebugMode ? "sahil.vehiclemarketplace@gmail.com" : "");
  TextEditingController passwordController = TextEditingController(text: kDebugMode ? "12345678" : "");
  TextEditingController otpController = TextEditingController();
  bool show = true;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordOtpSent) {
          CommonMethods().showTopFlash(context: context, message: state.message, isSuccess: true);
        }
        if (state is ForgotPasswordOtpSendFailed) {
          CommonMethods().showTopFlash(context: context, message: state.error);
        }
        if (state is ForgotPasswordOtpVerificationFailed) {
          CommonMethods().showTopFlash(context: context, message: state.error);
        }
        if (state is ForgotPasswordOtpVerified) {
          CommonMethods().showTopFlash(context: context, message: state.message, isSuccess: true);
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
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
                          verticalSpacer(),
                          if (state is ForgotPasswordOtpNotVerified)
                            Column(
                              children: [
                                MyEditText(
                                  AppConstants.passwordHint1,
                                  true,
                                  TextInputType.text,
                                  TextCapitalization.none,
                                  10.0,
                                  passwordController,
                                  Colours.hintColor.code,
                                  true,
                                  textInputAction: TextInputAction.next,
                                ),
                                verticalSpacer(),
                                MyEditText(
                                  AppConstants.otpText1,
                                  false,
                                  TextInputType.number,
                                  TextCapitalization.none,
                                  10.0,
                                  otpController,
                                  Colours.hintColor.code,
                                  true,
                                  textInputAction: TextInputAction.done,
                                ),
                              ],
                            ),
                          verticalSpacer(),
                          state is Loading
                              ? const Center(child: CircularProgressIndicator())
                              : GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    validate(state);
                                  },
                                  child: appButton(
                                      bkColor: Colours.blue.code,
                                      text: state is ForgotPasswordOtpNotVerified
                                          ? AppConstants.verifyHint
                                          : AppConstants.otpText)),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }

  validate(AuthState state) {
    if (emailController.text == "") {
      CommonMethods().showTopFlash(context: context, message: "Email is required.");
      return;
    }
    if (!EmailValidator.validate(emailController.text.trim())) {
      CommonMethods().showTopFlash(context: context, message: "Invalid email.");
      return;
    }
    if (state is ForgotPasswordOtpNotSend) {
      _requestOtp(context);
    } else {
      if (passwordController.text.length < 6) {
        CommonMethods().showTopFlash(context: context, message: "Enter minimum 6 characters for password");
        return;
      }
      if (otpController.text == "") {
        CommonMethods().showTopFlash(context: context, message: "OTP is required.");
        return;
      }
      _verifyOtp(context);
    }
  }

  void _requestOtp(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      OtpRequested(
        emailController.text,
      ),
    );
  }

  void _verifyOtp(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      ResetPasswordRequested(emailController.text, otpController.text.trim(), passwordController.text),
    );
  }
}
