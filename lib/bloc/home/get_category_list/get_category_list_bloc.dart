import 'dart:async';

import 'package:app/data/repository/get_categoryList_repository.dart';
import 'package:app/data/repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/get_category_list_model.dart';

part 'get_category_list_event.dart';

part 'get_category_list_state.dart';

class GetCategoryListBloc extends Bloc<GetCategoryListEvent, GetCategoryListState> {
  final GetCategoryListRepository getCategoryListRepository;

  GetCategoryListBloc({required this.getCategoryListRepository}) : super(Loading()) {
    on<GetCateGoryList>(_getCategoryList);
  }

  Future<FutureOr<void>> _getCategoryList(
      GetCateGoryList event,
      Emitter<GetCategoryListState> emit,
      ) async {
    emit(Loading());
    try {
      final res = await getCategoryListRepository.getCategoryList();
      if (res['status'] == 1) {
        GetCategoryList getCategoryList=GetCategoryList.fromJson(res);
        emit(GetCategoryListSuccessfully(data: getCategoryList.serviceCategory));
      } else {
        emit(GetCategoryListFailed(res['message']));
      }
    } catch (e) {
      emit(GetCategoryListFailed(e.toString()));
    }
  }
}
