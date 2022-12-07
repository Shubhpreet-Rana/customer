part of 'booking_bloc.dart';

abstract class GetMyBookingListEvent {
  const GetMyBookingListEvent();
}

class GetBookingInitialStateEvent extends GetMyBookingListEvent {
  const GetBookingInitialStateEvent();
}

class GetBookingBannerEvent extends GetMyBookingListEvent {
  const GetBookingBannerEvent();
}

class GetBookingListEvent extends GetMyBookingListEvent {
  final bool isLoadingInitialState;
  final bool isLoadingMoreDataState;
  final bool isPaginationStartFromFirstPage;

  const GetBookingListEvent({
    required this.isLoadingInitialState,
    required this.isLoadingMoreDataState,
    required this.isPaginationStartFromFirstPage,
  });
}
