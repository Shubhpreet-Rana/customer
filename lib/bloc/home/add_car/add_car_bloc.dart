import 'dart:async';
import 'dart:io';
import 'package:app/common/methods/common.dart';
import 'package:app/common/services/NavigationService.dart';
import 'package:app/data/repository/home_repository.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../view_cars/view_car_bloc.dart';

part 'add_car_event.dart';

part 'sell_car_state.dart';

class SellCarBloc extends Bloc<SellCarEvent, AddCarToSellState> {
  final HomeRepository homeRepository;

  SellCarBloc({required this.homeRepository}) : super(InitialState()) {
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
        brandName: event.brandName,
        modelName: event.modelName,
        capacity: event.capacity,
        carImage_1: event.carImage_1,
        carImage_2: event.carImage_2,
        carImage_3: event.carImage_3,
        color: event.color,
        description: event.description,
        mileage: event.mileage,
        manufacturingYear: event.manufacturingYear,
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
        brand_name: event.brandName,
        model_name: event.modelName,
        capacity: event.capacity,
        car_image_1: event.carImage_1,
        car_image_2: event.carImage_2,
        car_image_3: event.carImage_3,
        color: event.color,
        description: event.description,
        mileage: event.mileage,
        manufacturing_year: event.manufacturingYear,
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
