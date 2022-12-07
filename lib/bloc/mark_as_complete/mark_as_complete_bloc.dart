import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../common/methods/common.dart';
import '../../common/services/NavigationService.dart';
import '../../data/repository/mark_as_cpmplete_repository.dart';
import '../../main.dart';
import '../../screens/home/home_tabs.dart';
import '../../screens/home/pages/calender.dart';
import '../booking/booking_bloc.dart';

part 'mark_as_complete_event.dart';

part 'mark_as_complete_state.dart';

class MarkAsCompleteBloc extends Bloc<MarkAsCompleteEvent, MarkAsCompleteState> {
  MarkAsCompleteBloc({required this.markAsCompleteRepository}) : super(const MarkAsCompleteInitialState()) {
    on<MarkAsCompleteRequestEvent>(_markAsComplete);
  }

  final MarkAsCompleteRepository markAsCompleteRepository;

  Future<FutureOr<void>> _markAsComplete(MarkAsCompleteRequestEvent event, Emitter<MarkAsCompleteState> emit) async {
    try {
      emit(const MarkAsCompleteLoadingState());
      var res = await markAsCompleteRepository.markAsComplete(
        amount: event.amount,
        description: event.description,
        status: event.status,
        bookingId: event.bookingId,
      );
      if (res['status'] == 1) {
        CommonMethods().showToast(
          context: locator<NavigationService>().navigatorKey.currentContext!,
          message: "Booking canceled successfully",
          isRedColor: false,
        );
        BlocProvider.of<BookingBloc>(locator<NavigationService>().navigatorKey.currentContext!).add(
          const GetBookingListEvent(isLoadingInitialState: true, isLoadingMoreDataState: false, isPaginationStartFromFirstPage: true),
        );
        calenderScreen.currentState?.popUntil((route) => route.isFirst);
        emit(const MarkAsCompleteSuccessfulState());
      } else {
        CommonMethods().showToast(
          context: locator<NavigationService>().navigatorKey.currentContext!,
          message: res['message'],
        );
        emit(const MarkAsCompleteInitialState());
      }
    } catch (e) {
      emit(const MarkAsCompleteInitialState());
      rethrow;
    }
  }
}
