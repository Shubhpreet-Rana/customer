import 'dart:async';
import 'package:app/data/repository/delete_my_markertplace_vehicle_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_my_marketplace_vehicle_event.dart';

part 'delete_my_marketplace_vehicle_state.dart';

class DeleteMarketPlaceVehicleBloc extends Bloc<DeleteMarketPlaceVehicleEvent, DeleteMarketPlaceVehicleState> {
  final DeleteMyMarketPlaceVehicleRepository deleteMyMarketPlaceVehicleRepository;

  DeleteMarketPlaceVehicleBloc({required this.deleteMyMarketPlaceVehicleRepository}) : super(InitialLoading()) {
    on<DeleteMyVehicleRequested>(_deletedMyVehicle);
  }

  Future<FutureOr<void>> _deletedMyVehicle(
    DeleteMyVehicleRequested event,
    Emitter<DeleteMarketPlaceVehicleState> emit,
  ) async {
    emit(DeleteVehicleLoadingState());
    try {
      var res = await deleteMyMarketPlaceVehicleRepository.deleteMyMarketPlaceVehicle(id: event.id!);
      if (res["status"] == 200) {
        emit(DeletedMyVehicleSuccessfully("Success"));
      } else {
        emit(DeletedMyVehicleFailed("error"));
      }
    } catch (e) {
      emit(DeletedMyVehicleFailed("error"));
      debugPrint(e.toString());
    }
  }
}
