part of 'add_vehicle_bloc.dart';

@immutable
abstract class AddVehicleState extends Equatable {}

class LoadingUpdate extends AddVehicleState {
  @override
  List<Object?> get props => [];
}
class AddedSuccessfully extends AddVehicleState {
  final String success;
  AddedSuccessfully(this.success);
  @override
  List<Object?> get props => [];
}

class NotAdded extends AddVehicleState {
  @override
  List<Object?> get props => [];
}

class AddVehicleFailed extends AddVehicleState {
  final String error;

  AddVehicleFailed(this.error);
  @override
  List<Object?> get props => [error];
}