part of 'booking_bloc.dart';

@immutable
abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}
class GetBookingInitialState extends BookingState {
  const GetBookingInitialState();
}
class GetBookingLoadingState extends BookingState {
  final bool isLoadingInitialState;
  final bool isLoadingMoreDataState;

  const GetBookingLoadingState({
    this.isLoadingInitialState = false,
    this.isLoadingMoreDataState = false,
  });
}

class GetBookingSuccessState extends BookingState {
  final List<MyBookingData> myBookingList;
  final int isLastPage;

  const GetBookingSuccessState({
    required this.myBookingList,
    required this.isLastPage,
  });

  @override
  List<Object> get props => [myBookingList, isLastPage];
}
