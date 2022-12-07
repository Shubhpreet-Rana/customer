
part of 'add_card_bloc.dart';

abstract class AddCardEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class AddCardsRequested extends AddCardEvent {
  final String tokenId;
  AddCardsRequested({required this.tokenId});
}


