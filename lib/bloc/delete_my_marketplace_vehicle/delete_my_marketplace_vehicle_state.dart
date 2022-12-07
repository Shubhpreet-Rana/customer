part of 'delete_my_marketplace_vehicle_bloc.dart';
class DeleteMarketPlaceVehicleState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialLoading extends DeleteMarketPlaceVehicleState {}

class DeleteVehicleLoadingState extends DeleteMarketPlaceVehicleState {}

class DeletedMyVehicleSuccessfully extends DeleteMarketPlaceVehicleState {
  final String message;

  DeletedMyVehicleSuccessfully(this.message);

  @override
  List<Object> get props => [message];
}

class DeletedMyVehicleFailed extends DeleteMarketPlaceVehicleState {
  final String error;

  DeletedMyVehicleFailed(this.error);

  @override
  List<Object> get props => [error];
}
