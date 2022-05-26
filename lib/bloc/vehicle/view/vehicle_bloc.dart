import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/add_vehicle_repository.dart';
import '../../../model/vehicle.dart';

part 'vehicle_event.dart';

part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleRepository vehicleRepository;

  VehicleBloc({required this.vehicleRepository}) : super(VehicleInitial()) {
    on<VehicleFetchEvent>(_fetchCurrentUserVehicle);
  }

  FutureOr<void> _fetchCurrentUserVehicle(VehicleFetchEvent event, Emitter<VehicleState> emit) async {
    try {
      emit(VehicleLoading());
      final userVehicle = await vehicleRepository.getUserVehiclesDetails();
      if (userVehicle != null) emit(VehicleLoaded(myVehicles: userVehicle));
    } catch (e) {
      emit(VehicleError(message: e.toString()));
    }
  }
}
