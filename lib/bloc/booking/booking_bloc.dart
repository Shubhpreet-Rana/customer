import 'dart:async';

import 'package:app/data/repository/booking_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/my_bookings.dart';

part 'booking_event.dart';

part 'booking_state.dart';

class BookingBloc extends Bloc<GetMyBookingListEvent, BookingState> {
  final BookingRepository bookingRepository;

  BookingBloc({required this.bookingRepository}) : super(const GetBookingLoadingState(isLoadingInitialState: true)) {
    on<GetBookingListEvent>(_getAllMyBookings);
  }

  int _currentPage = 1;
  final List<MyBookingData> _localBookingList = [];

  Future<FutureOr<void>> _getAllMyBookings(
    GetBookingListEvent event,
    Emitter<BookingState> emit,
  ) async {
    try {
      emit(GetBookingLoadingState(isLoadingMoreDataState: event.isLoadingMoreDataState, isLoadingInitialState: event.isLoadingInitialState));
      if (event.isPaginationStartFromFirstPage) {
        _currentPage = 1;
        _localBookingList.clear();
      }
      final Map<String, dynamic> res = await bookingRepository.getAllMyBookings(_currentPage.toString());
      if (res['status'] == 1) {
        MyBooking myBooking = MyBooking.fromJson(res);
        if (myBooking.data.isEmpty) {
          emit(const GetBookingInitialState());
        } else {
          _currentPage++;
          _localBookingList.addAll(myBooking.data);
          emit(GetBookingSuccessState(myBookingList: _localBookingList, isLastPage: myBooking.isLastPage));
        }
      } else {
        emit(const GetBookingInitialState());
      }
    } catch (e) {
      emit(const GetBookingInitialState());
      rethrow;
    }
  }
}
