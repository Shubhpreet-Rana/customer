part of 'get_category_list_bloc.dart';

@immutable
abstract class GetCategoryListState extends Equatable {}

class Loading extends GetCategoryListState {
  @override
  List<Object?> get props => [];
}

class GetCategoryListSuccessfully extends GetCategoryListState {
 List<CategoryList>? data;

  GetCategoryListSuccessfully({this.data});

  @override
  List<Object?> get props => [data];
}

class NoLisy extends GetCategoryListState {
  final String noData;

  NoLisy(this.noData);

  @override
  List<Object?> get props => [noData];
}

class GetCategoryListFailed extends GetCategoryListState {
  final String error;

  GetCategoryListFailed(this.error);

  @override
  List<Object?> get props => [error];
}
