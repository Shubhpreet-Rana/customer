part of 'get_card_bloc.dart';

class CardState extends Equatable {
  const CardState();

  @override
  List<Object?> get props => [];
}

class GetCardState extends CardState {
  final int selectedCard;

  const GetCardState({
    required this.selectedCard,
  });

  GetCardState copyWith({
    int? selectedCard,
  }) =>
      GetCardState(
        selectedCard: selectedCard ?? this.selectedCard,
      );

  @override
  List<Object> get props => [selectedCard];
}

class GetCardsInitialLoading extends CardState {}

class GetCardsLoading extends CardState {}

class GetCardSuccessfully extends CardState {
  final dynamic cardList;

  const GetCardSuccessfully(this.cardList);

  @override
  // TODO: implement props
  List<Object> get props => [cardList];
}

class GetCardsFailed extends CardState {
  final String? error;

  const GetCardsFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error!];
}

class GetSelectedCardValue extends CardState {
  final dynamic selectedValue;

  const GetSelectedCardValue(this.selectedValue);

  @override
  List<Object> get props => [selectedValue!];
}
