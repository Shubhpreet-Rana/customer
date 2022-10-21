import 'dart:async';
import 'dart:convert';

import 'package:app/common/methods/common.dart';
import 'package:app/model/getCategoryListModel.dart';
import 'package:app/model/getServiceProviderList_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../common/services/NavigationService.dart';
import '../../data/repository/service_provider_repository.dart';
import '../../main.dart';

part 'service_provider_state.dart';

part 'service_provider_event.dart';

class ServiceProviderBloc extends Bloc<ServiceProviderEvent, ServiceProviderState> {
  ServiceProviderBloc({required this.serviceProviderRepository}) : super(CategoryListLoading()) {
    on<GetCategoryList>(categoryList);
    on<AllServiceProviderList>(getAllServiceProviders);
    on<BookService>(bookService);
  }

  ServiceProviderRepository serviceProviderRepository;
  List<ProviderData> providerData = <ProviderData>[];

  Future<FutureOr<void>> categoryList(
    ServiceProviderEvent event,
    Emitter<ServiceProviderState> emit,
  ) async {
    List<ServiceCategoryData>? serviceCategory = [];
    emit(CategoryListLoading());
    try {
      final res = await serviceProviderRepository.getCategoryList();
      if (res['status'] == 1) {
        CategoryList categoryList = CategoryList.fromJson(res);
        serviceCategory.addAll(categoryList.serviceCategory!);
        if (serviceCategory.isNotEmpty) {
          emit(state.copyWith(categoryList: serviceCategory));
        }
      } else {
        emit(CategoryListFailed(res['message']));
      }
    } catch (e) {
      emit(CategoryListFailed(e.toString()));
    }
  }

  Future<FutureOr<void>> getAllServiceProviders(
    AllServiceProviderList event,
    Emitter<ServiceProviderState> emit,
  ) async {
    emit(CarScreenLoading());
    try {
      final res = await serviceProviderRepository.getAllServiceProvider(categoryName: event.name, catid: event.catid, rating: event.rating, location: event.location);
      if (res['status'] == 1) {
        GetServiceProviderList getServiceProviderList = GetServiceProviderList.fromJson(res);
        print(getServiceProviderList);
        providerData = getServiceProviderList.data!;
        emit(GetAllServiceProviderFetchSuccessfully(providerData));
      } else {
        emit(CategoryListFailed(res['message']));
      }
    } catch (e) {
      emit(CategoryListFailed(e.toString()));
    }
  }

  Future<FutureOr<void>> bookService(
    BookService event,
    Emitter<ServiceProviderState> emit,
  ) async {
    emit(BookServiceLoading(providerData));
    try {
      final res = await serviceProviderRepository.bookService(
          amount: event.amount,
          date: event.date,
          service_cat_id: event.service_cat_id,
          address_lat: event.address_lat,
          address_long: event.address_long,
          gst_amount: event.gst_amount,
          time: event.time);
      if (res['status'] == 1) {
        CommonMethods().showToast(context: locator<NavigationService>().navigatorKey.currentContext!, message: "Service booked successfully");
        emit(BookingSuccessfully(providerData));
      } else {
        emit(BookingFailed(res['message'], providerData));
      }
    } catch (e) {
      emit(BookingFailed(e.toString(), providerData));
    }
  }
}
