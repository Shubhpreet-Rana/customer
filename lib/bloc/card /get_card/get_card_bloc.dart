import 'dart:async';

import 'package:app/data/repository/get_cards_repository.dart';
import 'package:app/model/card_list_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_card_event.dart';

part 'get_card_state.dart';

class GetCardBloc extends Bloc<GetCardEvent, GetCardState> {
  final GetCardRepository getCardRepository;

  GetCardBloc({required this.getCardRepository}) : super(GetCardsInitialLoading()) {
    on<GetCardsRequested>(_getCards);
    on<GetSelectedCard>(_getSelectedCard);
  }

  Future<FutureOr<void>> _getCards(GetCardsRequested event, Emitter<GetCardState> emit) async {
    emit(GetCardsLoading());
    try {
      var res = await getCardRepository.getCards();
      if (res['status'] == 1) {
        emit(GetCardSuccessfully(res["data"]));
      } else {
        emit(GetCardsFailed('error'));
      }
    } catch (e) {}
  }

  FutureOr<void> _getSelectedCard(GetSelectedCard event, Emitter<GetCardState> emit) {
    try {
     emit(GetSelectedCardValue(event.selectedCard));
    } catch (e) {
      print(e.toString());
    }
  }
}
