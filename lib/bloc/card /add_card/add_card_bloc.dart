import 'dart:async';

import 'package:app/data/repository/add_card_repository.dart';
import 'package:app/data/repository/get_cards_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_card_state.dart';

part 'add_card_event.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  final AddCardRepository addCardRepository;

  AddCardBloc({required this.addCardRepository}) : super(Loading()) {
    on<AddCardsRequested>(_addCards);
  }

  Future<FutureOr<void>> _addCards(AddCardsRequested event, Emitter<AddCardState> emit) async {
    emit(Loading());
    try {
      var res = await addCardRepository.addCard(tokenId: event.tokenId);
      if (res['status'] == 1) {
        emit(AddCardSuccessfully(res["data"]));
      } else {
        emit(AddCardsFailed('error'));
      }
    } catch (e) {}
  }
}
