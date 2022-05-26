import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/add_vehicle_repository.dart';
import '../../../screens/vehicle/vehicle_details.dart';

part 'add_vehicle_state.dart';

part 'add_vehicle_event.dart';

class AddVehicleBloc extends Bloc<AddVehicleEvent, AddVehicleState> {
  AddVehicleBloc({required this.addVehicleRepository}) : super(NotAdded()) {
    on<AddVehicleRequested>(_addVehicle);
    on<VehicleEvent>((event, emit) => emit(NotAdded()));
  }

  final VehicleRepository addVehicleRepository;

  Future<FutureOr<void>> _addVehicle(
    AddVehicleRequested event,
    Emitter<AddVehicleState> emit,
  ) async {
    emit(LoadingUpdate());
    Map<String, dynamic>? res;
    try {
      for (var car in event.cars) {
        res = await addVehicleRepository.addVehicle(car: car);
      }
      if (res!['status'] == 1) {
        emit(AddedSuccessfully(res['message']));
      } else {
        emit(AddVehicleFailed(res['message']));
        emit(NotAdded());
      }
    } catch (e) {
      emit(AddVehicleFailed(e.toString()));
      emit(NotAdded());
    }
  }
}
