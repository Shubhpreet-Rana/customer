import 'dart:async';

import 'package:app/data/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/all_vehicle_model.dart';
import '../../../model/my_marketplace_vehicle.dart';

part 'view_car_event.dart';

part 'view_car_state.dart';

class ViewCarBloc extends Bloc<ViewCarEvent, ViewCarState> {
  final HomeRepository homeRepository;

  ViewCarBloc({required this.homeRepository}) : super(GetAllVehicleLoading()) {
    on<GetAllVehicle>(_getAllVehicle);
    on<GetMyMarketVehicle>(_getMyMarketVehicle);
    on<FetchAllVehicle>(_changeFetchValueAllVehicle);
    on<FetchMyMarketVehicle>(_changeFetchValueMyMarketVehicle);
  }

  Future<FutureOr<void>> _getAllVehicle(
    GetAllVehicle event,
    Emitter<ViewCarState> emit,
  ) async {
    if (event.page == null) emit(GetAllVehicleLoading());
    try {
      final res = await homeRepository.getAllVehicle(event.page ?? "1");
      if (res['status'] == 1) {
        AllVehicel allVehicle = AllVehicel.fromJson(res);
        if (allVehicle.vehicle!.isEmpty) {
          emit(NoAllVehicleFound("No vehicle found"));
          emit(state.copyWith(hasMoreData: false));
        } else {
          emit(state.copyWith(vehicle: allVehicle.vehicle!));
          int currentPage = state.currentPage!;
          currentPage++;
          emit(state.copyWith(currentPage: currentPage));
          emit(state.copyWith(isLoading: false));
          emit(state.copyWith(isFetchingMore: false));
          emit(GetAllVehicleSuccessfully(data: allVehicle.vehicle));
        }
      } else {
        emit(NoAllVehicleFound(res['message']));
      }
    } catch (e) {
      emit(NoAllVehicleFound(e.toString()));
    }
  }

  Future<FutureOr<void>> _getMyMarketVehicle(
    GetMyMarketVehicle event,
    Emitter<ViewCarState> emit,
  ) async {
    if (event.page == null) emit(GetMyMarketLoading());
    try {
      final res = await homeRepository.getMyMarketVehicle(event.page ?? "");
      if (res['status'] == 1) {
        MyMarketPlaceVehicle allVehicle = MyMarketPlaceVehicle.fromJson(res);
        if (allVehicle.vehicle!.isEmpty) {
          emit(NoMyMarketVehicleFound("No vehicle found"));
        } else {
          emit(state.copyWith(myMarketPlaceVehicle: allVehicle.vehicle!));
          if (allVehicle.vehicle!.length == 0) {
            emit(state.copyWith(hasMoreDataMyMarket: false));
          }
          int currentPage = state.currentPageMyMarket!;
          currentPage++;
          emit(state.copyWith(currentPageMyMarket: currentPage));
          emit(state.copyWith(isLoadingMyMarket: false));
          emit(state.copyWith(isFetchingMoreMyMarket: false));
          emit(MyMarketPlaceVehicles(myMarketVehicle: allVehicle.vehicle));
        }
      } else {
        emit(NoMyMarketVehicleFound(res['message']));
      }
    } catch (e) {
      emit(NoMyMarketVehicleFound(e.toString()));
    }
  }

  Future<FutureOr<void>> _changeFetchValueAllVehicle(
      FetchAllVehicle event, Emitter<ViewCarState> emit) async {
    emit(state.copyWith(isFetchingMore: event.fetchingMore));
  }

  Future<FutureOr<void>> _changeFetchValueMyMarketVehicle(
      FetchMyMarketVehicle event, Emitter<ViewCarState> emit) async {
    emit(state.copyWith(isFetchingMoreMyMarket: event.fetchingMore));
  }
}
