part of 'vehicle_bloc.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object> get props => [];
}

class VehicleFetchEvent extends VehicleEvent {}
class VehicleEditEvent extends VehicleEvent {}
class EditVehicleRequested extends VehicleEvent {
  const EditVehicleRequested(this.cars);

  final List<EditCar> cars;
}
