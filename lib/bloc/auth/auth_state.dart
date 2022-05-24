part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoggedInSuccessfully extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoggedInSuccessfullyProfileSetup extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoggedInSuccessfullyAddVehicle extends AuthState {
  @override
  List<Object?> get props => [];
}

class NotLoggedIn extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoggedInFailed extends AuthState {
  final String error;

  LoggedInFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class RegisteredSuccessfully extends AuthState {
  @override
  List<Object?> get props => [];
}

class NotRegistered extends AuthState {
  @override
  List<Object?> get props => [];
}

class RegisteredFailed extends AuthState {
  final String error;

  RegisteredFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class ForgotPasswordOtpSent extends AuthState {
  final String message;

  ForgotPasswordOtpSent(this.message);

  @override
  List<Object?> get props => [];
}

class ForgotPasswordOtpNotSend extends AuthState {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordOtpSendFailed extends AuthState {
  final String error;

  ForgotPasswordOtpSendFailed(this.error);

  @override
  List<Object?> get props => [];
}

class ForgotPasswordOtpVerified extends AuthState {
  final String message;

  ForgotPasswordOtpVerified(this.message);

  @override
  List<Object?> get props => [];
}

class ForgotPasswordOtpNotVerified extends AuthState {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordOtpVerificationFailed extends AuthState {
  final String error;

  ForgotPasswordOtpVerificationFailed(this.error);

  @override
  List<Object?> get props => [];
}
