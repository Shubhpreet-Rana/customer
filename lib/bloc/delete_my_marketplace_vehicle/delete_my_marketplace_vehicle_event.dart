part of 'delete_my_marketplace_vehicle_bloc.dart';

@immutable
abstract class DeleteMarketPlaceVehicleEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class DeleteMyVehicleRequested extends DeleteMarketPlaceVehicleEvent {
  String? id;

  DeleteMyVehicleRequested({this.id});
}
