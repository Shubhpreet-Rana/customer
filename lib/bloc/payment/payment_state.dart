part of 'payment_bloc.dart';
class PaymentState extends  Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class InitialLoading extends PaymentState{}

class Loading extends PaymentState{}

class PaymentProceeded extends PaymentState{
  final dynamic response;
  PaymentProceeded(this.response);
  @override
  // TODO: implement props
  List<Object?> get props => [response];

}
class PaymentFailed extends PaymentState{
  final String? error;
  PaymentFailed(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}
class ApplePaymentSuccessful extends PaymentState{
  final dynamic res;
  ApplePaymentSuccessful(this.res);
  @override
  // TODO: implement props
  List<Object?> get props => [res];
}
class ApplePaymentFailed extends PaymentState{
  final String err;
  ApplePaymentFailed(this.err);
  @override
  // TODO: implement props
  List<Object?> get props => [err];
}