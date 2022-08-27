part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetBanner extends BookingEvent {

}
class LoadBookings extends BookingEvent {
  String? page;

  LoadBookings({this.page});

}
class FetchMoreBookings extends BookingEvent {
  bool? fetchingMore;

  FetchMoreBookings({this.fetchingMore});

}

