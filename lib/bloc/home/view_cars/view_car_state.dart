part of 'view_car_bloc.dart';

class ViewCarState extends Equatable {
  final String pageSize = "20";
  final int? currentPage;
  final bool? hasMoreData;

  final bool? isLoading;
  final bool? isFetchingMore;
  final List<AllVehicleData>? vehicle;

  final int? currentPageMyMarket;
  final bool? hasMoreDataMyMarket;

  final bool? isLoadingMyMarket;
  final bool? isFetchingMoreMyMarket;
  final List<MyVehicleMarketPlace>? myMarketPlaceVehicle;

  const ViewCarState(
      {this.currentPage = 1,
      this.hasMoreData = true,
      this.isLoading = true,
      this.isFetchingMore = false,
      this.vehicle,
      this.currentPageMyMarket = 1,
      this.hasMoreDataMyMarket = true,
      this.isLoadingMyMarket = true,
      this.isFetchingMoreMyMarket = false,
      this.myMarketPlaceVehicle});

  ViewCarState copyWith({
    int? currentPage,
    bool? hasMoreData,
    bool? isLoading,
    bool? isFetchingMore,
    List<AllVehicleData>? vehicle,
    int? currentPageMyMarket,
    bool? hasMoreDataMyMarket,
    bool? isLoadingMyMarket,
    bool? isFetchingMoreMyMarket,
    List<MyVehicleMarketPlace>? myMarketPlaceVehicle,
  }) =>
      ViewCarState(
          currentPage: currentPage ?? this.currentPage,
          hasMoreData: hasMoreData ?? this.hasMoreData,
          isLoading: isLoading ?? this.isLoading,
          isFetchingMore: isFetchingMore ?? this.isFetchingMore,
          vehicle: vehicle ?? this.vehicle,
          currentPageMyMarket: currentPageMyMarket ?? this.currentPageMyMarket,
          hasMoreDataMyMarket: hasMoreDataMyMarket ?? this.hasMoreDataMyMarket,
          isLoadingMyMarket: isLoadingMyMarket ?? this.isLoadingMyMarket,
          isFetchingMoreMyMarket:
              isFetchingMoreMyMarket ?? this.isFetchingMoreMyMarket,
          myMarketPlaceVehicle:
              myMarketPlaceVehicle ?? this.myMarketPlaceVehicle);

  @override
  // TODO: implement props
  List<Object?> get props => [
        currentPage!,
        hasMoreData!,
        isLoading!,
        isFetchingMore!,
        vehicle ?? [],
        currentPageMyMarket!,
        hasMoreDataMyMarket!,
        isLoadingMyMarket!,
        isFetchingMoreMyMarket!,
        myMarketPlaceVehicle ?? []
      ];
}

class GetAllVehicleLoading extends ViewCarState {}

class GetMyMarketLoading extends ViewCarState {}

class GetAllVehicleSuccessfully extends ViewCarState {
  final List<AllVehicleData>? data;

  const GetAllVehicleSuccessfully({required this.data});

  @override
  List<Object> get props => [data!];
}

class NoAllVehicleFound extends ViewCarState {
  final String noData;

  const NoAllVehicleFound(this.noData);

  @override
  List<Object> get props => [noData];
}

class MyMarketPlaceVehicles extends ViewCarState {
  final  List<MyVehicleMarketPlace>? myMarketVehicle;

  const MyMarketPlaceVehicles({this.myMarketVehicle});

  @override
  List<Object> get props => [myMarketVehicle!];
}

class NoMyMarketVehicleFound extends ViewCarState {
  final  String noData;

  const NoMyMarketVehicleFound(this.noData);

  @override
  List<Object> get props => [noData];
}
