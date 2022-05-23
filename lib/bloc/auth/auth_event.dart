part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LogInRequested extends AuthEvent {
  LogInRequested(this.email, this.password);

  final String email;
  final String password;
}

class LogInEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {}

class RegisterRequested extends AuthEvent {
  RegisterRequested(this.email, this.password, this.confirmPassword);

  final String email;
  final String password;
  final String confirmPassword;
}

class RecoverEmailEvent extends AuthEvent {}

class OtpRequested extends AuthEvent {
  OtpRequested(this.email);

  final String email;
}

class LogOutRequested extends AuthEvent {}
