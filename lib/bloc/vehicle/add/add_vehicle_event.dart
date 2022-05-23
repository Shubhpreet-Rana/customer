part of 'add_vehicle_bloc.dart';

abstract class AddVehicleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VehicleEvent extends AddVehicleEvent {}

class AddVehicleRequested extends AddVehicleEvent {
  AddVehicleRequested(this.cars);

  final List<Car> cars;
}
