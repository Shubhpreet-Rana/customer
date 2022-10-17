part of 'add_card_bloc.dart';

class AddCardState extends Equatable {
  int? selectedCard;

  AddCardState({
    this.selectedCard = 0,
  });

  AddCardState copyWith({
    int? selectedCard,
  }) =>
      AddCardState(
        selectedCard: selectedCard ?? this.selectedCard,
      );

  @override
  List<Object> get props => [selectedCard!];
}

class InitialLoading extends AddCardState {}

class Loading extends AddCardState {}

class AddCardSuccessfully extends AddCardState {
  dynamic response;

  AddCardSuccessfully(this.response);

  @override
  // TODO: implement props
  List<Object> get props => [response];
}

class AddCardsFailed extends AddCardState {
  String? error;

  AddCardsFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error!];
}
