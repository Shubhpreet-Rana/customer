import 'dart:async';
import 'dart:convert';

import 'package:app/common/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../common/methods/custom_storage.dart';
import '../../data/repository/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(NotLoggedIn()) {
    on<LogInRequested>(_logInUser);
    on<RegisterRequested>(_registerUser);
    on<RegisterEvent>((event, emit) => emit(NotRegistered()));
    on<LogInEvent>((event, emit) => emit(NotLoggedIn()));
    on<OtpRequested>(_sendOtp);
    on<RecoverEmailEvent>((event, emit) => emit(ForgotPasswordOtpNotSend()));
    on<LogOutRequested>(  _logOutUser);
  }

  final AuthRepository authRepository;

  FutureOr<void> _logInUser(
    LogInRequested event,
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
    RegisterRequested event,
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
        emit(NotLoggedIn());  });
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
      OtpRequested event,
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

  FutureOr<void> _logOutUser(LogOutRequested event, Emitter<AuthState> emit) async {
    //await locator.prefs.clear();
    emit(NotLoggedIn());
  }
}
