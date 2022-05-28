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

class LoadingEditUpdate extends VehicleState {
  List<Object?> get props1 => [];
}
class EditedSuccessfully extends VehicleState {
  final String success;
  const EditedSuccessfully(this.success);
  List<Object?> get props1 => [];
}

class NotEdited extends VehicleState {
  List<Object?> get props1 => [];
}

class EditVehicleFailed extends VehicleState {
  final String error;

  const EditVehicleFailed(this.error);
  List<Object?> get props1 => [error];
}
