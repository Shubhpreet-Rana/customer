import 'dart:async';
import 'package:app/data/repository/charge_user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'charge_user_event.dart';

part 'charge_user_state.dart';

class ChargeUserBloc extends Bloc<ChargeUserEvent, ChargeUserState> {
  final ChargeUserRepository chargeUserRepository;

  ChargeUserBloc({required this.chargeUserRepository}) : super(Loading()) {
    on<ChargeUserRequested>(_chargeUser);
  }

  Future<FutureOr<void>> _chargeUser(ChargeUserRequested event, Emitter<ChargeUserState> emit) async {
    emit(Loading());
    try {
      var res = await chargeUserRepository.chargeUser(amount: event.amount, cardId: event.cardId, providerId: event.providerId,
      bookingId: event.bookingId);
      if (res['status'] == 1) {
        emit(ChargeUserSuccessfully(res["data"]));
      } else {
        emit(ChargeUserFailed('error'));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
