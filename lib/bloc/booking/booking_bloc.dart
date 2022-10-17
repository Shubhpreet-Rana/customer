import 'dart:async';

import 'package:app/data/repository/booking_repository.dart';
import 'package:app/data/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/my_bookings.dart';

part 'booking_event.dart';

part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;

  BookingBloc({required this.bookingRepository}) : super(Loading()) {
    on<LoadBookings>(_getAllMyBookings);
    on<FetchMoreBookings>((_changeFetchValue));
  }

  Future<FutureOr<void>> _getAllMyBookings(
    LoadBookings event,
    Emitter<BookingState> emit,
  ) async {
    if (event.page == null) emit(Loading());
    try {
      final res = await bookingRepository.getAllMyBookings(event.page ?? "1");
      if (res['status'] == 1) {
        MyBooking myBooking = MyBooking.fromJson(res);
        if (myBooking.data!.isEmpty) {
          emit(MyBookingNoData("No bookings found"));
        } else {
          emit(state.copyWith(myBookingList: myBooking.data));
          if (myBooking.data!.length == 0) {
            emit(state.copyWith(hasMoreData: false));
          }
          int currentPage = state.currentPage!;
          currentPage++;
          emit(state.copyWith(currentPage: currentPage));
          emit(state.copyWith(isLoading: false));
          emit(state.copyWith(isFetchingMore: false));
        }
      } else {
        emit(MyBookingNoData("No bookings found"));
      }
    } catch (e) {
      emit(GetBookingFailed(e.toString()));
    }
  }

  Future<FutureOr<void>> _changeFetchValue(FetchMoreBookings event, Emitter<BookingState> emit) async {
    emit(state.copyWith(isFetchingMore: event.fetchingMore));
  }

}
