import 'dart:async';

import 'package:app/data/repository/payment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_state.dart';

part 'payment_event.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;

  PaymentBloc({required this.paymentRepository}) : super(InitialLoading()) {
    on<MakePaymentEvent>(_makePayment);
    on<MakeApplePayment>(_applePayment);
  }

  Future<FutureOr<void>> _makePayment(MakePaymentEvent event, Emitter<PaymentState> emit) async {
    emit(Loading());
    try {
      final res = await paymentRepository.makePayment(amount: event.amount, currency: event.currency);
      if (res.isNotEmpty) {
        emit(PaymentProceeded(res));
      } else {
        emit(PaymentFailed("asjdhas"));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<FutureOr<void>> _applePayment(MakeApplePayment event, Emitter<PaymentState> emit) async {
    emit(Loading());
    try {
      dynamic res = await paymentRepository.makePayment(amount: event.amount, currency: event.currency);
      if (res.isNotEmpty) {
        emit(ApplePaymentSuccessful(res));
      } else {
        emit(ApplePaymentFailed("bjcbjjcnas"));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
