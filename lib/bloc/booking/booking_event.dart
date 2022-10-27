part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetBookingBanner extends BookingEvent {}

class LoadBookings extends BookingEvent {
  final String? page;

  LoadBookings({this.page});
}

class FetchMoreBookings extends BookingEvent {
  final bool? fetchingMore;

  FetchMoreBookings({this.fetchingMore});
}

class GetMostPopularBookingList extends BookingEvent {}
