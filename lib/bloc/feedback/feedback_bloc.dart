import 'dart:async';
import 'package:app/data/repository/add_feedback_repository.dart';
import 'package:app/data/repository/delete_my_markertplace_vehicle_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'feedback_event.dart';

part 'feedback_state.dart';

class AddFeedbackBloc extends Bloc<AddFeedbackEvent, AddFeedbackState> {
  final AddFeedbackRepository addFeedbackRepository;

  AddFeedbackBloc({required this.addFeedbackRepository}) : super(InitialLoading()) {
    on<FeedBackRequested>(_addFeedBack);
  }

  Future<FutureOr<void>> _addFeedBack(
      FeedBackRequested event,
      Emitter<AddFeedbackState> emit,
      ) async {
    emit(Loading());
    try {
      var res = await addFeedbackRepository.addFeedback(
        providerId: event.providerId,
        feedText: event.feed,
        rating: event.rating
      );
      if (res["status"] == 200) {
        emit(AddFeedbackSuccessfully("Success"));
      } else {
        emit(AddFeedbackFailed("error"));
      }
    } catch (e) {
      emit(AddFeedbackFailed("error"));
      debugPrint(e.toString());
    }
  }
}
