part of 'payment_bloc.dart';
class PaymentState extends  Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class InitialLoading extends PaymentState{}

class Loading extends PaymentState{}

class PaymentProceeded extends PaymentState{
  dynamic response;
  PaymentProceeded(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}
class PaymentFailed extends PaymentState{
  String? error;
  PaymentFailed(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}
class ApplePaymentSuccessful extends PaymentState{
  dynamic res;
  ApplePaymentSuccessful(this.res);
  @override
  // TODO: implement props
  List<Object?> get props => [res];
}
class ApplePaymentFailed extends PaymentState{
  String err;
  ApplePaymentFailed(this.err);
  @override
  // TODO: implement props
  List<Object?> get props => [err];
}