import 'dart:async';

import 'package:app/data/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/banner_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(Loading()) {
    on<GetBanner>(_getBanner);
  }

  Future<FutureOr<void>> _getBanner(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(Loading());
    try {
      final res = await homeRepository.getBanners();
      if (res['status'] == 1) {
        BannerModel bannerModel = BannerModel.fromJson(res['data']);
        emit(GetBannerSuccessfully(bannerData: bannerModel));
      } else {
        emit(GetBannerFailed(res['message']));
      }
    } catch (e) {
      emit(GetBannerFailed(e.toString()));
    }
  }
}
