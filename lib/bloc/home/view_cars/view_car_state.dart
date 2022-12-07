part of 'view_car_bloc.dart';

abstract class AllVehicleState extends Equatable {
  const AllVehicleState();

  @override
  List<Object> get props => [];
}

class AllVehicleInitialState extends AllVehicleState {
  const AllVehicleInitialState();
}

class AllVehicleLoadingState extends AllVehicleState {
  final bool isInitialLoadingState;
  final bool isFetchingMoreLoadingState;

  const AllVehicleLoadingState({
    required this.isInitialLoadingState,
    required this.isFetchingMoreLoadingState,
  });

  @override
  List<Object> get props => [isInitialLoadingState, isFetchingMoreLoadingState];
}

class AllVehicleLoadedState extends AllVehicleState {
  final List<AllVehicleData> allVehicleList;
  final bool isLastPage;

  const AllVehicleLoadedState(
      {required this.allVehicleList, required this.isLastPage});

  @override
  List<Object> get props => [allVehicleList, isLastPage];
}

abstract class MyMarketVehicleState extends Equatable {
  const MyMarketVehicleState();

  @override
  List<Object> get props => [];
}

class MyMarketVehicleInitialState extends MyMarketVehicleState {
  const MyMarketVehicleInitialState();
}

class MyMarketVehicleLoadingState extends MyMarketVehicleState {
  final bool isInitialLoadingState;
  final bool isFetchingMoreLoadingState;

  const MyMarketVehicleLoadingState({
    required this.isInitialLoadingState,
    required this.isFetchingMoreLoadingState,
  });

  @override
  List<Object> get props => [isInitialLoadingState, isFetchingMoreLoadingState];
}

class MyMarketVehicleLoadedState extends MyMarketVehicleState {
  final List<MyVehicleMarketPlace> myMarketVehicle;
  final bool isLastPage;

  const MyMarketVehicleLoadedState(
      {required this.myMarketVehicle, required this.isLastPage});

  @override
  List<Object> get props => [myMarketVehicle, isLastPage];
}
