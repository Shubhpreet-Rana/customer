part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  @override
  List<Object?> get props;
}

class MakePaymentEvent extends PaymentEvent {
  final String? amount;
  final String? currency;

  MakePaymentEvent({this.amount, this.currency});

  @override
  List<Object?> get props => [amount,currency];
}

class MakeApplePayment extends PaymentEvent {
  final String? amount;
  final String? currency;

  MakeApplePayment({this.amount, this.currency});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
