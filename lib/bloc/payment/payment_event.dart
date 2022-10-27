part of 'payment_bloc.dart';

class PaymentEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MakePaymentEvent extends PaymentEvent {
  final  String? amount;
  final String? currency;

  MakePaymentEvent({this.amount, this.currency});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MakeApplePayment extends PaymentEvent {
  final  String? amount;
  final  String? currency;

  MakeApplePayment({this.amount, this.currency});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
