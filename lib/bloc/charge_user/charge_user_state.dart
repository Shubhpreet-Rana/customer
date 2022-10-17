part of 'charge_user_bloc.dart';

class ChargeUserState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialLoading extends ChargeUserState {}

class Loading extends ChargeUserState {}

class ChargeUserSuccessfully extends ChargeUserState {
  dynamic response;

  ChargeUserSuccessfully(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

class ChargeUserfailed extends ChargeUserState {
  String? error;

  ChargeUserfailed(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
