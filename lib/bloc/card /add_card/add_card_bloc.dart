import 'dart:async';
import 'package:app/common/services/NavigationService.dart';
import 'package:app/data/repository/add_card_repository.dart';
import 'package:app/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_card_state.dart';

part 'add_card_event.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  final AddCardRepository addCardRepository;

  AddCardBloc({required this.addCardRepository}) : super(AddCardInitialState()) {
    on<AddCardsRequested>(_addCards);
  }

  Future<FutureOr<void>> _addCards(AddCardsRequested event, Emitter<AddCardState> emit) async {
    emit(AddCardLoadingState());
    try {
      var res = await addCardRepository.addCard(tokenId: event.tokenId);
      if (res['status'] == 1) {
        // locator<NavigationService>().navigatorKey.currentState?.pop();
        // locator<NavigationService>().navigatorKey.currentState?.pop();
        emit(AddCardSuccessState(res["data"]));
      } else {
        emit(const AddCardsFailed(error: 'error'));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
