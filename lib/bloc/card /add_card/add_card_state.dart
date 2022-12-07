part of 'add_card_bloc.dart';

abstract class AddCardState extends Equatable {
  const AddCardState();

  @override
  List<Object?> get props => [];
}

class AddCardInitialState extends AddCardState {}

class AddCardLoadingState extends AddCardState {}

class AddCardSuccessState extends AddCardState {
  final dynamic response;

  const AddCardSuccessState(this.response);

  @override
  List<Object?> get props => [response];
}

class AddCardsFailed extends AddCardState {
  final String error;

  const AddCardsFailed({required this.error});

  @override
  List<Object> get props => [error];
}
