import 'dart:async';

import 'package:app/bloc/payment/payment_repository/payment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_state.dart';

part 'payment_event.dart';


class PaymentBloc extends Bloc<PaymentEvent, PaymentState>  {
  final  PaymentRepository paymentReository;

  PaymentBloc({required this.paymentReository}) : super(InitialLoading()) {
    on<MakePaymentEvent>(_makePayment);

  }



  Future<FutureOr<void>> _makePayment(MakePaymentEvent event, Emitter<PaymentState> emit) async {
    emit(Loading());
    try{
      final res= await paymentReository.makePayment();
      if(res.isNotEmpty){

      }

    }catch(e){
      print(e.toString());
    }
  }
}
