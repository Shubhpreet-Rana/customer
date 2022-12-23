import 'dart:io';
import 'package:app/common/constants.dart';
import 'package:app/common/methods/common.dart';
import 'package:app/common/styles/styles.dart';
import 'package:app/common/ui/headers.dart';
import 'package:app/screens/registration/forgot_password.dart';
import 'package:app/screens/registration/profile_setup.dart';
import 'package:app/screens/registration/signup.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/profile/view/profile_bloc.dart';
import '../../common/assets.dart';
import '../../common/colors.dart';
import '../../common/methods/custom_storage.dart';
import '../../common/ui/background.dart';
import '../../common/ui/common_ui.dart';
import '../../common/ui/edit_text.dart';
import '../home/home_tabs.dart';
import '../vehicle/vehicle_details.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController(/*text: kDebugMode ?"testcustomer4@gmail.com" : ""*/);
  final TextEditingController _passwordController = TextEditingController(/*text: kDebugMode ? "12345678" : ""*/);
  bool _rememberMe = false;

  @override
  void initState() {
    _getRememberMe();
    super.initState();
  }

  Future<void> _getRememberMe() async {
    _rememberMe = await PreferenceUtils.getBool(AppConstants.rememberMe);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: BlocListener<SocialAuthBloc, SocialAuthState>(
        listener: (context, state) {
          if (state is SocialAuthSuccessState) {
            PreferenceUtils.setBool(AppConstants.rememberMe, _rememberMe);
            if (state.screenName == 'setup_profile') {
              Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => const ProfileSetUpScreen()));
            } else if (state.screenName == 'add_vehicle') {
              Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => const VehicleDetails()));
            } else {
              context.read<ProfileBloc>().add(ProfileFetchEvent());
              Navigator.of(context, rootNavigator: true).pushReplacement(CupertinoPageRoute(builder: (context) => const HomeTabs()));
            }
          } else if (state is SocialAuthLoadingState) {
            _commonLoader();
          } else if (state is! SocialAuthSuccessState) {
            Navigator.of(context).pop();
          }
        },
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoggedInSuccessfullyProfileSetup) {
              Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => const ProfileSetUpScreen()));
            }
            if (state is LoggedInSuccessfullyAddVehicle) {
              Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => const VehicleDetails()));
              //  Navigator.of(context, rootNavigator: true).pushReplacement(CupertinoPageRoute(builder: (context) => const HomeTabs()));
            }
            if (state is LoggedInSuccessfully) {
              PreferenceUtils.setBool(AppConstants.rememberMe, _rememberMe);
              context.read<ProfileBloc>().add(ProfileFetchEvent());
              Navigator.of(context, rootNavigator: true).pushReplacement(CupertinoPageRoute(builder: (context) => const HomeTabs()));
            }
            if (state is LoggedInFailed) {
              CommonMethods().showToast(context: context, message: state.error);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Scaffold(
                body: BackgroundImage(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: AppHeaders().extendedHeader(
                          text: AppConstants.login,
                          context: context,
                          backNavigation: false,
                        ),
                      ),
                      verticalSpacer(height: 40.0),
                      Expanded(
                        child: Container(
                          width: CommonMethods.deviceWidth(),
                          height: CommonMethods.deviceHeight(),
                          padding: const EdgeInsets.only(
                            left: 30.0,
                            right: 30.0,
                            bottom: 5.0,
                            top: 40.0,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(33),
                              topRight: Radius.circular(33),
                            ),
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppConstants.welcome,
                                  style: AppStyles.darkText,
                                ),
                                verticalSpacer(
                                  height: 30.0,
                                ),
                                MyEditText(AppConstants.emailHint, false, TextInputType.emailAddress, TextCapitalization.none, 10.0, _emailController, Colours.hintColor.code, true),
                                verticalSpacer(),
                                MyEditText(
                                  AppConstants.passwordHint,
                                  true,
                                  TextInputType.text,
                                  TextCapitalization.none,
                                  10.0,
                                  _passwordController,
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
                                      child: Checkbox(
                                          value: _rememberMe, checkColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), onChanged: _onRememberMeChanged),
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
                                state is Loading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          _validate();
                                        },
                                        child: appButton(bkColor: Colours.blue.code, text: AppConstants.login1)),
                                verticalSpacer(),
                                Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: "${AppConstants.forgotPwd} ", style: AppStyles.blackText),
                                        TextSpan(
                                          text: AppConstants.recover,
                                          style: AppStyles.textBlue,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              context.read<AuthBloc>().add(
                                                    RecoverEmailEvent(),
                                                  );
                                              Navigator.of(context, rootNavigator: true).push(
                                                CupertinoPageRoute(
                                                  builder: (context) => const ForgotPassword(),
                                                ),
                                              );
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                verticalSpacer(height: 40.0),
                                socialButton(
                                  bkColor: Colours.darkBlue.code,
                                  text: AppConstants.fb,
                                  icon: Assets.fb.name,
                                  onTap: () async {
                                    BlocProvider.of<SocialAuthBloc>(context).add(
                                      const SocialAuthSignInEvent(
                                        isFacebookSignInEvent: true,
                                      ),
                                    );
                                  },
                                ),
                                verticalSpacer(),
                                socialButton(
                                  bkColor: Colours.red.code,
                                  text: AppConstants.google,
                                  icon: Assets.google.name,
                                  onTap: () async {
                                    BlocProvider.of<SocialAuthBloc>(context).add(
                                      const SocialAuthSignInEvent(
                                        isGoogleSignInEvent: true,
                                      ),
                                    );
                                  },
                                ),
                                verticalSpacer(height: 20.0),
                                if (Platform.isIOS)
                                  socialButton(
                                    bkColor: Colors.black.withOpacity(0.9),
                                    text: AppConstants.apple,
                                    icon: null,
                                    onTap: () async {
                                      BlocProvider.of<SocialAuthBloc>(context).add(
                                        const SocialAuthSignInEvent(
                                          isAppleSignInEvent: true,
                                        ),
                                      );
                                    },
                                  ),
                                verticalSpacer(
                                  height: 30.0,
                                ),
                                Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: "${AppConstants.dontAccount} ", style: AppStyles.blackText),
                                        TextSpan(
                                          text: AppConstants.signUp1,
                                          style: AppStyles.textBlue,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              context.read<AuthBloc>().add(
                                                    RegisterEvent(),
                                                  );
                                              await Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => const SignUpScreen()));
                                              if (mounted) {
                                                context.read<AuthBloc>().add(LogInEvent());
                                              }
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
            },
          ),
        ),
      ),
    );
  }

  void _onRememberMeChanged(bool? newValue) => setState(() {
        _rememberMe = newValue!;
        if (mounted) {
          setState(() {});
        }
      });

  void _validate() {
    if (_emailController.text == "") {
      CommonMethods().showToast(context: context, message: "Email is required.");
    } else if (!EmailValidator.validate(_emailController.text.trim())) {
      CommonMethods().showToast(context: context, message: "Invalid email.");
    } else if (_passwordController.text.length < 6) {
      CommonMethods().showToast(context: context, message: "Enter minimum 6 characters for password");
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      _createAccountWithEmailAndPassword(context);
    }
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(
      LogInRequestedEvent(
        _emailController.text,
        _passwordController.text,
      ),
    );
  }

  void _commonLoader() {
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 50, minHeight: 50, maxWidth: 50, maxHeight: 50),
        child: Row(
          children: [
            const Center(
              child: CircularProgressIndicator(),
            ),
            horizontalSpacer(width: 20),
            const Text("Login...")
          ],
        ),
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
