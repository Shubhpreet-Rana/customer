part of 'add_card_bloc.dart';

class AddCardState extends Equatable {
  final int? selectedCard;

  const AddCardState({
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
  final dynamic response;

  const AddCardSuccessfully(this.response);

  @override
  // TODO: implement props
  List<Object> get props => [response];
}

class AddCardsFailed extends AddCardState {
  final String? error;

  const AddCardsFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error!];
}
