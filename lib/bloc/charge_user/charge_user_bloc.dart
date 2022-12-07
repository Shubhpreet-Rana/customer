import 'dart:async';
import 'package:app/data/repository/charge_user_repository.dart';
import 'package:app/screens/home/home_tabs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common/services/NavigationService.dart';
import '../../main.dart';
import '../../screens/home/pages/calender.dart';
import '../booking/booking_bloc.dart';

part 'charge_user_event.dart';

part 'charge_user_state.dart';

class ChargeUserBloc extends Bloc<ChargeUserEvent, ChargeUserState> {
  final ChargeUserRepository chargeUserRepository;

  ChargeUserBloc({required this.chargeUserRepository}) : super(InitialLoading()) {
    on<ChargeUserRequested>(_chargeUser);
  }

  Future<FutureOr<void>> _chargeUser(ChargeUserRequested event, Emitter<ChargeUserState> emit) async {
    emit(Loading());
    try {
      var res = await chargeUserRepository.chargeUser(amount: event.amount, cardId: event.cardId, providerId: event.providerId,
      bookingId: event.bookingId);
      if (res['status'] == 1) {
        BlocProvider.of<BookingBloc>(locator<NavigationService>().navigatorKey.currentContext!).add(
          const GetBookingListEvent(isLoadingInitialState: true, isLoadingMoreDataState: false, isPaginationStartFromFirstPage: true),
        );
        calenderScreen.currentState?.pop();
        emit(ChargeUserSuccessfully(res["data"]));
      } else {
        emit(ChargeUserFailed(res["message"]));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(ChargeUserFailed(e.toString()));
    }
  }
}
