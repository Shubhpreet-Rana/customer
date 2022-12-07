import 'dart:async';
import 'dart:convert';
import 'package:app/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../common/methods/common.dart';
import '../../common/methods/custom_storage.dart';
import '../../common/services/NavigationService.dart';
import '../../common/social_auth.dart';
import '../../data/repository/auth_repository.dart';
import '../../main.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(NotLoggedIn()) {
    on<LogInRequestedEvent>(_logInUser);
    on<RegisterRequestedEvent>(_registerUser);
    on<RegisterEvent>((event, emit) => emit(NotRegistered()));
    on<LogInEvent>((event, emit) => emit(NotLoggedIn()));
    on<OtpRequestedEvent>(_sendOtp);
    on<RecoverEmailEvent>((event, emit) => emit(ForgotPasswordOtpNotSend()));
    on<ResetPasswordRequestedEvent>(_resetPassword);
    on<ResetPasswordEvent>((event, emit) => emit(ForgotPasswordOtpNotVerified()));
    on<LogOutRequestedEvent>(_logOutUser);
  }

  final AuthRepository authRepository;

  FutureOr<void> _logInUser(
    LogInRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    try {
      final res = await authRepository.logIn(
        email: event.email,
        password: event.password,
      );

      if (res['status'] == 1) {
        await PreferenceUtils.setString(AppConstants.userInfo, json.encode(res)).then((value) {
          if (res['user']['screen'] == "setup_profile") {
            emit(LoggedInSuccessfullyProfileSetup());
          } else if (res['user']['screen'] == "add_vehicle") {
            emit(LoggedInSuccessfullyAddVehicle());
          } else {
            emit(LoggedInSuccessfully());
          }
        });
      } else {
        emit(LoggedInFailed(res['message']));
        emit(NotLoggedIn());
      }
    } catch (e) {
      emit(LoggedInFailed(e.toString()));
      emit(NotLoggedIn());
    }
  }

  FutureOr<void> _registerUser(
    RegisterRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    try {
      final res = await authRepository.register(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );
      if (res['status'] == 1) {
        await PreferenceUtils.setString(AppConstants.userInfo, json.encode(res)).then((value) {
          emit(RegisteredSuccessfully());
          emit(NotLoggedIn());
        });
      } else {
        emit(RegisteredFailed(res['message']));
        emit(NotRegistered());
      }
    } catch (e) {
      emit(RegisteredFailed(e.toString()));
      emit(NotRegistered());
    }
  }

  FutureOr<void> _sendOtp(
    OtpRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    try {
      final res = await authRepository.sendOtpToEmail(
        email: event.email,
      );
      if (res['status'] == 1) {
        emit(ForgotPasswordOtpSent(res['message']));
        emit(ForgotPasswordOtpNotVerified());
      } else {
        emit(ForgotPasswordOtpSendFailed(res['message']));
        emit(ForgotPasswordOtpNotSend());
      }
    } catch (e) {
      emit(ForgotPasswordOtpSendFailed(e.toString()));
      emit(ForgotPasswordOtpNotSend());
    }
  }

  FutureOr<void> _resetPassword(
    ResetPasswordRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    try {
      final res = await authRepository.resetPassword(
        email: event.email,
        otp: event.otp,
        password: event.password,
      );
      if (res['status'] == 1) {
        emit(ForgotPasswordOtpVerified(res['message']));
      } else {
        emit(ForgotPasswordOtpVerificationFailed(res['message']));
        emit(ForgotPasswordOtpNotVerified());
      }
    } catch (e) {
      emit(ForgotPasswordOtpVerificationFailed(e.toString()));
      emit(ForgotPasswordOtpNotVerified());
    }
  }

  FutureOr<void> _logOutUser(LogOutRequestedEvent event, Emitter<AuthState> emit) async {
    //await locator.prefs.clear();
    emit(NotLoggedIn());
  }
}

class SocialAuthBloc extends Bloc<SocialAuthEvent, SocialAuthState> {
  SocialAuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const SocialAuthInitialState()) {
    on<SocialAuthSignInEvent>(_socialAuthEvent);
  }

  final AuthRepository _authRepository;

  FutureOr<void> _socialAuthEvent(
      SocialAuthSignInEvent event, Emitter<SocialAuthState> emit) async {
    BuildContext context =
    locator<NavigationService>().navigatorKey.currentContext!;
    try {
      SocialAuthModel? socialAuthUserCredentials;
      String loginType = "";
      if (event.isGoogleSignInEvent) {
        loginType = "google_id";
        socialAuthUserCredentials = await googleAuth();
      } else if (event.isFacebookSignInEvent) {
        loginType = "facebook_id";
        socialAuthUserCredentials = await facebookAuth();
      } else if (event.isAppleSignInEvent) {
        loginType = "apple_id";
        socialAuthUserCredentials = await appleAuth();
      }
      emit(const SocialAuthLoadingState());
      if (socialAuthUserCredentials != null &&
          socialAuthUserCredentials.providerId.isNotEmpty) {
        if (loginType == "google_id" &&
            socialAuthUserCredentials.email.isEmpty) {
          CommonMethods()
              .showToast(context: context, message: "Email not found.");
          emit(const SocialAuthInitialState());
          return;
        }
        final res = await _authRepository.socialSignIn(
            socialAuthUserCredentials: socialAuthUserCredentials,
            loginType: loginType);
        if (res['status'] == 1) {
          emit(const SocialAuthSuccessState());
        } else {
          CommonMethods().showToast(
            context: context,
            message: res['message'],
          );
          emit(const SocialAuthInitialState());
        }
      } else {
        emit(const SocialAuthInitialState());
      }
    } catch (e) {
      CommonMethods().showToast(
        context: context,
        message: e.toString(),
      );
      emit(const SocialAuthInitialState());
    }
  }
}