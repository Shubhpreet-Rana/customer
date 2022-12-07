part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LogInRequestedEvent extends AuthEvent {
  LogInRequestedEvent(this.email, this.password);

  final String email;
  final String password;
}

class LogInEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {}

class RegisterRequestedEvent extends AuthEvent {
  RegisterRequestedEvent(this.email, this.password, this.confirmPassword);

  final String email;
  final String password;
  final String confirmPassword;
}

class RecoverEmailEvent extends AuthEvent {}

class OtpRequestedEvent extends AuthEvent {
  OtpRequestedEvent(this.email);

  final String email;
}

class ResetPasswordEvent extends AuthEvent {}

class ResetPasswordRequestedEvent extends AuthEvent {
  ResetPasswordRequestedEvent(this.email, this.otp, this.password);

  final String email;
  final String otp;
  final String password;
}

class LogOutRequestedEvent extends AuthEvent {}

abstract class SocialAuthEvent {
  const SocialAuthEvent();
}

class SocialAuthSignInEvent extends SocialAuthEvent {
  final bool isGoogleSignInEvent;
  final bool isFacebookSignInEvent;
  final bool isAppleSignInEvent;

  const SocialAuthSignInEvent({
    this.isAppleSignInEvent = false,
    this.isFacebookSignInEvent = false,
    this.isGoogleSignInEvent = false,
  });
}