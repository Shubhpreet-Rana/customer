part of 'charge_user_bloc.dart';

abstract class ChargeUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChargeUserRequested extends ChargeUserEvent {
  final String? providerId;
  final String? cardId;
  final String? amount;
  final String? bookingId;

  ChargeUserRequested({this.cardId, this.amount, this.providerId,this.bookingId});

  @override
  List<Object> get props => [];
}
