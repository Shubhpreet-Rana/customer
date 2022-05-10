import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(NotLoggedIn()) {
    on<LogInRequested>(_logInUser);
    on<RegisterRequested>(_registerUser);
    on<RegisterEvent>((event, emit) => emit(NotRegistered()));
    on<LogInEvent>((event, emit) => emit(NotLoggedIn()));
    on<LogOutRequested>(_logOutUser);
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

      if (res['success'] == true) {
       /* await locator.setUserToken(userToken: res["token"]).then((value) {
          emit(LoggedInSuccessfully());
        });*/
      } else {
        emit(LoggedInFailed(res['msg']));
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
      if (res['message'] == "Registration Successful") {
        emit(RegisteredSuccessfully());
        emit(NotLoggedIn());
      } else {
        emit(RegisteredFailed(res['message']));
        emit(NotRegistered());
      }
    } catch (e) {
      emit(RegisteredFailed(e.toString()));
      emit(NotRegistered());
    }
  }

  FutureOr<void> _logOutUser(
      LogOutRequested event, Emitter<AuthState> emit) async {
    //await locator.prefs.clear();
    emit(NotLoggedIn());
  }
}
