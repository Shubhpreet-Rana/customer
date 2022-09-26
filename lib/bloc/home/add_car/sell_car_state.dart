part of 'add_car_bloc.dart';

class AddCarToSellState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Loading extends AddCarToSellState {}

class initialState extends AddCarToSellState {}

class AddCarSuccessfully extends AddCarToSellState {}

class UpdateCarSuccessFully extends AddCarToSellState {}

class SellCarFailed extends AddCarToSellState {
  final String failedMsg;

  SellCarFailed(this.failedMsg);

  @override
  List<Object> get props => [];
}
class UpdateSellCarFailed extends AddCarToSellState {
  final String failedMsg;

  UpdateSellCarFailed(this.failedMsg);

  @override
  List<Object> get props => [];
}

class ImageSelected1Successfully extends AddCarToSellState {
  final String? imagePath;

  ImageSelected1Successfully({this.imagePath});

  @override
  List<Object> get props => [imagePath!];
}

class ImageSelected2Successfully extends AddCarToSellState {
  final String? imagePath;

  ImageSelected2Successfully({this.imagePath});

  @override
  List<Object> get props => [imagePath!];
}

class ImageSelected3Successfully extends AddCarToSellState {
  final String? imagePath;

  ImageSelected3Successfully({this.imagePath});

  @override
  List<Object> get props => [imagePath!];
}
