part of 'get_category_list_bloc.dart';

@immutable
abstract class GetCategoryListState extends Equatable {}

class Loading extends GetCategoryListState {
  @override
  List<Object?> get props => [];
}

class GetCategoryListSuccessfully extends GetCategoryListState {
 final List<CategoryList>? data;

  GetCategoryListSuccessfully({this.data});

  @override
  List<Object?> get props => [data];
}

class NoList extends GetCategoryListState {
  final String noData;

  NoList(this.noData);

  @override
  List<Object?> get props => [noData];
}

class GetCategoryListFailed extends GetCategoryListState {
  final String error;

  GetCategoryListFailed(this.error);

  @override
  List<Object?> get props => [error];
}
