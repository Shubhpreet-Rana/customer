part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final String pageSize = "5";
  final int? currentPage;
  final bool? hasMoreData;

  final bool? isLoading;
  final bool? isFetchingMore;
  final List<MyBookingData>? myBookingList;
  final List<MyBookingData>? getPopularList;

  const BookingState({
    this.currentPage = 1,
    this.hasMoreData = true,
    this.isLoading = true,
    this.isFetchingMore = false,
    this.myBookingList,
    this.getPopularList
  });

  BookingState copyWith({
    int? currentPage,
    bool? hasMoreData,
    bool? isLoading,
    bool? isFetchingMore,
    List<MyBookingData>? myBookingList,
    List<MyBookingData>? getPopularList
  }) =>
      BookingState(
        currentPage: currentPage ?? this.currentPage,
        hasMoreData: hasMoreData ?? this.hasMoreData,
        isLoading: isLoading ?? this.isLoading,
        isFetchingMore: isFetchingMore ?? this.isFetchingMore,
        myBookingList: myBookingList??this.myBookingList,
        getPopularList: getPopularList??this.getPopularList
      );

  @override
  List<Object> get props =>
      [currentPage!, hasMoreData!, isLoading!, isFetchingMore!,myBookingList??[],getPopularList??[]];
}

class BookingLoading extends BookingState {
}
class MyBookingNoData extends BookingState {
  final String message;

  const MyBookingNoData(this.message);

  @override
  List<Object> get props => [message];
}
class GetBookingFailed extends BookingState {
  final String error;

  const GetBookingFailed(this.error);

  @override
  List<Object> get props => [error];
}
