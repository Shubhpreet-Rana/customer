part of 'service_provider_bloc.dart';

class ServiceProviderState extends Equatable {
  List<ServiceCategoryData>? categoryList;

  ServiceProviderState({this.categoryList});

  ServiceProviderState copyWith({
    List<ServiceCategoryData>? categoryList,
  }) =>
      ServiceProviderState(categoryList: categoryList ?? this.categoryList);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoryListLoading extends ServiceProviderState {
  @override
  List<Object?> get props => [categoryList ?? []];
}

class CarScreenLoading extends ServiceProviderState {
  @override
  List<Object?> get props => [];
}

class BookServiceLoading extends ServiceProviderState {

  List<ProviderData> providerData;
  BookServiceLoading(this.providerData);
  @override
  List<Object> get props => [providerData];
}

class CategoryListFetchSuccessfully extends ServiceProviderState {
  List<ServiceCategoryData>? serviceCategory;

  CategoryListFetchSuccessfully(this.serviceCategory);

  @override
  List<Object?> get props => [serviceCategory!];
}

class CategoryListFailed extends ServiceProviderState {
  final String? error;

  CategoryListFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class GetAllServiceProviderFetchSuccessfully extends ServiceProviderState {
  List<ProviderData> providerData;

  GetAllServiceProviderFetchSuccessfully(this.providerData) : super();

  @override
  List<Object> get props => [providerData];
}

class GetAllServiceProviderFailed extends ServiceProviderState {
  final String? error;

  GetAllServiceProviderFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class BookingSuccessfully extends ServiceProviderState {
  List<ProviderData> providerData;

  BookingSuccessfully(this.providerData);

  @override
  List<Object> get props => [providerData];
}

class BookingFailed extends ServiceProviderState {
  final String error;
  List<ProviderData> providerData;

  BookingFailed(this.error,this.providerData);

  @override
  List<Object?> get props => [providerData,error];
}
