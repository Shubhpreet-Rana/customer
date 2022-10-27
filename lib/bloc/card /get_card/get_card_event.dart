part of 'get_card_bloc.dart';

abstract class GetCardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCardsRequested extends GetCardEvent {}

class GetSelectedCard extends GetCardEvent {
  final int? selectedCard;

  GetSelectedCard(this.selectedCard);

  @override
  List<Object> get props => [selectedCard!];
}
