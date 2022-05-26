part of 'vehicle_bloc.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object> get props => [];
}

class VehicleInitial extends VehicleState {}

class VehicleLoading extends VehicleState {}

class VehicleLoaded extends VehicleState {
  final Vehicles? myVehicles;
  const VehicleLoaded({
    required this.myVehicles,
  });
}

class VehicleError extends VehicleState {
  final String message;
  const VehicleError({
    required this.message,
  });
}
