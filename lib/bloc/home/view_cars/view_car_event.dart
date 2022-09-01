part of 'view_car_bloc.dart';

abstract class ViewCarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllVehicle extends ViewCarEvent {
  String? page;

  GetAllVehicle({this.page});
}

class GetMyMarketVehicle extends ViewCarEvent {
  String? page;

  GetMyMarketVehicle({this.page});
}

class FetchAllVehicle extends ViewCarEvent {
  bool? fetchingMore;

  FetchAllVehicle({this.fetchingMore});

}
class FetchMyMarketVehicle extends ViewCarEvent {
  bool? fetchingMore;

  FetchMyMarketVehicle({this.fetchingMore});

}
