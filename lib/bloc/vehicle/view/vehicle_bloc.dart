import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/add_vehicle_repository.dart';
import '../../../model/vehicle.dart';
import '../../../screens/vehicle/edit_vehicle.dart';
import '../../../screens/vehicle/vehicle_details.dart';

part 'vehicle_event.dart';

part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleRepository vehicleRepository;

  VehicleBloc({required this.vehicleRepository}) : super(VehicleInitial()) {
    on<VehicleFetchEvent>(_fetchCurrentUserVehicle);
    on<EditVehicleRequested>(_editVehicle);
    on<VehicleEditEvent>((event, emit) => emit(NotEdited()));
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

  FutureOr<void> _editVehicle(EditVehicleRequested event, Emitter<VehicleState> emit) async {
    {
      emit(LoadingEditUpdate());
      Map<String, dynamic>? res;
      try {
        for (var car in event.cars) {
          res = await vehicleRepository.editVehicle(car: car);
        }
        if (res!['status'] == 1) {
          emit(EditedSuccessfully(res['message']));
        } else {
          emit(EditVehicleFailed(res['message']));
          emit(NotEdited());
        }
      } catch (e) {
        emit(EditVehicleFailed(e.toString()));
        emit(NotEdited());
      }
    }
  }
}
