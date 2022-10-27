part of 'charge_user_bloc.dart';

class ChargeUserState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialLoading extends ChargeUserState {}

class Loading extends ChargeUserState {}

class ChargeUserSuccessfully extends ChargeUserState {
  final dynamic response;

  ChargeUserSuccessfully(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class ChargeUserFailed extends ChargeUserState {
  final String? error;

  ChargeUserFailed(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
