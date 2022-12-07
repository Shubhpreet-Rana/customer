part of 'view_car_bloc.dart';

abstract class AllVehicleEvent {
  const AllVehicleEvent();
}

class AllVehicleRequestEvent extends AllVehicleEvent {
  final bool isInitialLoadingState;
  final bool isFetchingMoreLoadingState;
  final bool isPaginationStartFromFirstPage;

  const AllVehicleRequestEvent(
      {required this.isInitialLoadingState,
      required this.isFetchingMoreLoadingState,
      required this.isPaginationStartFromFirstPage});
}

abstract class MyMarketVehicleEvent {
  const MyMarketVehicleEvent();
}

class MyMarketVehicleRequestEvent extends MyMarketVehicleEvent {
  final bool isInitialLoadingState;
  final bool isFetchingMoreLoadingState;
  final bool isPaginationStartFromFirstPage;

  const MyMarketVehicleRequestEvent({
    required this.isInitialLoadingState,
    required this.isFetchingMoreLoadingState,
    required this.isPaginationStartFromFirstPage,
  });
}
