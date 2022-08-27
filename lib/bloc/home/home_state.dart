part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class Loading extends HomeState {
  @override
  List<Object?> get props => [];
}

class GetBannerSuccessfully extends HomeState {
  Map<dynamic, dynamic>? data;

  GetBannerSuccessfully({this.data});

  @override
  List<Object?> get props => [data];
}

class NoBanner extends HomeState {
  final String noData;

  NoBanner(this.noData);

  @override
  List<Object?> get props => [noData];
}

class GetBannerFailed extends HomeState {
  final String error;

  GetBannerFailed(this.error);

  @override
  List<Object?> get props => [error];
}
