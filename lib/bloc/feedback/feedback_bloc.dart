import 'dart:async';
import 'package:app/common/methods/common.dart';
import 'package:app/common/services/NavigationService.dart';
import 'package:app/data/repository/add_feedback_repository.dart';
import 'package:app/main.dart';
import 'package:app/screens/home/home_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'feedback_event.dart';

part 'feedback_state.dart';

class AddFeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final AddFeedbackRepository addFeedbackRepository;

  AddFeedbackBloc({required this.addFeedbackRepository}) : super(const FeedbackInitialState()) {
    on<FeedBackRequestedEvent>(_addFeedBack);
  }

  Future<FutureOr<void>> _addFeedBack(
    FeedBackRequestedEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    try {
      emit(const FeedbackLoadingState());
      var res = await addFeedbackRepository.addFeedback(
        providerId: event.providerId,
        feedText: event.description,
        rating: event.rating,
      );
      if (res["status"] == 200) {
        CommonMethods().showToast(
          context: locator<NavigationService>().navigatorKey.currentContext!,
          message: "Feedback given successfully",
          isRedColor: true,
        );
        calenderScreen.currentState!.popUntil((route) => route.isFirst);
        emit(const FeedbackSuccessState());
      } else {
        CommonMethods().showToast(
          context: locator<NavigationService>().navigatorKey.currentContext!,
          message: res['message'],
        );
        emit(const FeedbackInitialState());
      }
    } catch (e) {
      CommonMethods().showToast(
        context: locator<NavigationService>().navigatorKey.currentContext!,
        message: e.toString(),
      );
      emit(const FeedbackInitialState());
      debugPrint(e.toString());
    }
  }
}
