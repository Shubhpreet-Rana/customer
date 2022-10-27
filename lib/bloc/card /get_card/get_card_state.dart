part of 'get_card_bloc.dart';

class GetCardState extends Equatable {
  final int? selectedCard;

  const GetCardState({
    this.selectedCard = 0,
  });

  GetCardState copyWith({
    int? selectedCard,
  }) =>
      GetCardState(
        selectedCard: selectedCard ?? this.selectedCard,
      );

  @override
  List<Object> get props => [selectedCard!];
}

class GetCardsInitialLoading extends GetCardState {}

class GetCardsLoading extends GetCardState {}

class GetCardSuccessfully extends GetCardState {
  final dynamic cardList;

  const GetCardSuccessfully(this.cardList);

  @override
  // TODO: implement props
  List<Object> get props => [cardList];
}

class GetCardsFailed extends GetCardState {
  final String? error;

  const GetCardsFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error!];
}

class GetSelectedCardValue extends GetCardState{
  final dynamic  selectedValue;
  const GetSelectedCardValue(this.selectedValue);
  @override
  // TODO: implement props
  List<Object> get props => [selectedValue!];
}
