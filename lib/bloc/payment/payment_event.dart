part of 'payment_bloc.dart';

class PaymentEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MakePaymentEvent extends PaymentEvent {
  String? amount;
  String? currency;

  MakePaymentEvent({this.amount, this.currency});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
