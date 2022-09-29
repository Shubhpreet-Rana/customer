import 'dart:async';
import 'dart:io';

import 'package:app/common/methods/common.dart';
import 'package:app/data/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/all_vehicle_model.dart';

part 'add_car_event.dart';

part 'sell_car_state.dart';

class SellCarBloc extends Bloc<SellCarEvent, AddCarToSellState> {
  final HomeRepository homeRepository;

  SellCarBloc({required this.homeRepository}) : super(initialState()) {
    on<AddCarToSell>(_addCarToSell);
    on<Select1Image>(_selected1Image);
    on<Select2Image>(_selected2Image);
    on<Select3Image>(_selected3Image);
    on<UpdateCarToSell>(_updateCarToSell);
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

  Future<FutureOr<void>> _selected1Image(Select1Image event, Emitter<AddCarToSellState> emit) async {
    File? selectedImage = await CommonMethods().showAlertDialog(event.context);
    if (selectedImage != null && selectedImage.path.isNotEmpty) {
      emit(ImageSelected1Successfully(imagePath: selectedImage.path));
    }
  }

  Future<FutureOr<void>> _selected2Image(Select2Image event, Emitter<AddCarToSellState> emit) async {
    File? selectedImage = await CommonMethods().showAlertDialog(event.context);
    if (selectedImage != null && selectedImage.path.isNotEmpty) {
      emit(ImageSelected2Successfully(imagePath: selectedImage.path));
    }
  }

  Future<FutureOr<void>> _selected3Image(Select3Image event, Emitter<AddCarToSellState> emit) async {
    File? selectedImage = await CommonMethods().showAlertDialog(event.context);
    if (selectedImage != null && selectedImage.path.isNotEmpty) {
      emit(ImageSelected3Successfully(imagePath: selectedImage.path));
    }
  }

  Future<FutureOr<void>> _updateCarToSell(UpdateCarToSell event, Emitter<AddCarToSellState> emit) async {
    emit(Loading());
    try {
      final res = await homeRepository.updateCarVehicle(
        id: event.id,
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
        emit(UpdateCarSuccessFully());
      } else {
        emit(UpdateSellCarFailed(res['message']));
      }
    } catch (e) {
      emit(UpdateSellCarFailed(e.toString()));
    }
  }
}
