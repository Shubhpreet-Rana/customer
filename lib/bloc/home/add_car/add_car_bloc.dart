import 'dart:async';

import 'package:app/data/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/all_vehicle_model.dart';

part 'add_car_event.dart';

part 'sell_car_state.dart';

class SellCarBloc extends Bloc<SellCarEvent, AddCarToSellState> {
  final HomeRepository homeRepository;

  SellCarBloc({required this.homeRepository}) : super(initialState()) {
    on<AddCarToSell>(_addCarToSell);
  }

  Future<FutureOr<void>> _addCarToSell(
    AddCarToSell event,
    Emitter<AddCarToSellState> emit,
  ) async {
    emit(Loading());
    try {
      final res = await homeRepository.sellCarVehicle(
        brand_name: event.brand_name,
        model_name: event.model_name,
        capacity: event.capacity,
        car_image_1: event.car_image_1,
        car_image_2: event.car_image_2,
        car_image_3: event.car_image_3,
        color: event.color,
        description: event.description,
        mileage: event.mileage,
        manufacturing_year: event.manufacturing_year,
        address: event.address,
        address_lat: event.address_lat,
        address_long: event.address_long,
        price: event.price,
      );
      if (res['status'] == 1) {
        emit(AddCarSuccessfully());
      } else {
        emit(SellCarFailed(res['message']));
      }
    } catch (e) {
      emit(SellCarFailed(e.toString()));
    }
  }
}
