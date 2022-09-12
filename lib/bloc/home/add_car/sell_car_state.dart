part of 'add_car_bloc.dart';

class AddCarToSellState extends Equatable {


  @override
  // TODO: implement props
  List<Object?> get props => [
  ];
}

class Loading extends AddCarToSellState {}
class initialState extends AddCarToSellState {}


class AddCarSuccessfully extends AddCarToSellState {
}

class SellCarFailed  extends AddCarToSellState {
  final String failedMsg;

  SellCarFailed(this.failedMsg);

  @override
  List<Object> get props => [];
}


