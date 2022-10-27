part of 'view_car_bloc.dart';

abstract class ViewCarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllVehicle extends ViewCarEvent {
  final String? page;

  GetAllVehicle({this.page});
}

class GetMyMarketVehicle extends ViewCarEvent {
  final  String? page;

  GetMyMarketVehicle({this.page});
}

class FetchAllVehicle extends ViewCarEvent {
  final bool? fetchingMore;

  FetchAllVehicle({this.fetchingMore});

}
class FetchMyMarketVehicle extends ViewCarEvent {
  final  bool? fetchingMore;

  FetchMyMarketVehicle({this.fetchingMore});

}
