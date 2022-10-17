part of 'charge_user_bloc.dart';

abstract class ChargeUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChargeUserRequested extends ChargeUserEvent {
  String? providerId;
  String? cardId;
  String? amount;
  String? bookingId;

  ChargeUserRequested({this.cardId, this.amount, this.providerId,this.bookingId});

  @override
  List<Object> get props => [];
}
