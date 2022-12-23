import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../common/methods/common.dart';
import '../../../common/services/NavigationService.dart';
import '../../../data/repository/home_repository.dart';
import '../../../main.dart';
import '../../../model/all_vehicle_model.dart';
import '../../../model/my_marketplace_vehicle.dart';

part 'view_car_event.dart';

part 'view_car_state.dart';

final _navigatorKey = locator<NavigationService>().navigatorKey;

class AllVehicleBloc extends Bloc<AllVehicleEvent, AllVehicleState> {
  final HomeRepository homeRepository;

  AllVehicleBloc({required this.homeRepository}) : super(const AllVehicleInitialState()) {
    on<AllVehicleRequestEvent>(_getAllVehicle);
  }

  int _currentPageGetAllVehicle = 1;

  Future<FutureOr<void>> _getAllVehicle(
    AllVehicleRequestEvent event,
    Emitter<AllVehicleState> emit,
  ) async {
    emit(AllVehicleLoadingState(isInitialLoadingState: event.isInitialLoadingState, isFetchingMoreLoadingState: event.isFetchingMoreLoadingState));
    try {
      final res = await homeRepository.getAllVehicle(event.isPaginationStartFromFirstPage ? "1" : "$_currentPageGetAllVehicle");
      if (res['status'] == 1) {
        AllVehicle allVehicle = AllVehicle.fromJson(res);
        if (allVehicle.vehicle.isEmpty) {
          emit(const AllVehicleInitialState());
        } else {
          _currentPageGetAllVehicle++;
          emit(AllVehicleLoadedState(
            allVehicleList: allVehicle.vehicle,
            isLastPage: allVehicle.isLastPage == 1 ? true : false,
          ));
        }
      } else {
        CommonMethods().showToast(context: _navigatorKey.currentContext!, message: res['message'].toString().toLowerCase().contains("no vehicle found") ? "All vehicle not found" : res['message']);
        emit(const AllVehicleInitialState());
      }
    } catch (e) {
      CommonMethods().showToast(context: _navigatorKey.currentContext!, message: "$e");
      emit(const AllVehicleInitialState());
    }
  }
}

class MyMarketVehicleBloc extends Bloc<MyMarketVehicleEvent, MyMarketVehicleState> {
  final HomeRepository homeRepository;

  MyMarketVehicleBloc({required this.homeRepository}) : super(const MyMarketVehicleInitialState()) {
    on<MyMarketVehicleRequestEvent>(_getMyMarketVehicle);
  }

  int _currentPageGetMyMarketVehicle = 1;

  FutureOr<void> _getMyMarketVehicle(
    MyMarketVehicleRequestEvent event,
    Emitter<MyMarketVehicleState> emit,
  ) async {
    emit(MyMarketVehicleLoadingState(isInitialLoadingState: event.isInitialLoadingState, isFetchingMoreLoadingState: event.isFetchingMoreLoadingState));
    try {
      final res = await homeRepository.getMyMarketVehicle(event.isPaginationStartFromFirstPage ? "1" : "$_currentPageGetMyMarketVehicle");
      if (res['status'] == 1) {
        MyMarketPlaceVehicle allVehicle = MyMarketPlaceVehicle.fromJson(res);
        if (allVehicle.vehicle.isEmpty) {
          emit(MyMarketVehicleLoadedState(
            myMarketVehicle: allVehicle.vehicle,
            isLastPage: allVehicle.isLastPage == 1 ? true : false,
          ));
        } else {
          _currentPageGetMyMarketVehicle++;
          emit(MyMarketVehicleLoadedState(
            myMarketVehicle: allVehicle.vehicle,
            isLastPage: allVehicle.isLastPage == 1 ? true : false,
          ));
        }
      } else {
        if (res['status'] == 0 && res['message'] == 'No vehicle found') {
          emit(const MyMarketVehicleLoadedState(
            myMarketVehicle: [],
            isLastPage: true,
          ));
        } else {
          emit(const MyMarketVehicleInitialState());
        }
        CommonMethods()
            .showToast(context: _navigatorKey.currentContext!, message: res['message'].toString().toLowerCase().contains("no vehicle found") ? "My listed vehicle not found" : res['message']);
      }
    } catch (e) {
      CommonMethods().showToast(context: _navigatorKey.currentContext!, message: "$e");
      emit(const MyMarketVehicleInitialState());
    }
  }
}
