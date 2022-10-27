part of 'service_provider_bloc.dart';

class ServiceProviderState extends Equatable {
  final List<ServiceCategoryData>? categoryList;

  const ServiceProviderState({this.categoryList});

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

  final List<ProviderData> providerData;
  const BookServiceLoading(this.providerData);
  @override
  List<Object> get props => [providerData];
}

class CategoryListFetchSuccessfully extends ServiceProviderState {
  final List<ServiceCategoryData>? serviceCategory;

  const CategoryListFetchSuccessfully(this.serviceCategory);

  @override
  List<Object?> get props => [serviceCategory!];
}

class CategoryListFailed extends ServiceProviderState {
  final String? error;

  const CategoryListFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class GetAllServiceProviderFetchSuccessfully extends ServiceProviderState {
  final List<ProviderData> providerData;


  const GetAllServiceProviderFetchSuccessfully(this.providerData) : super();

  @override
  List<Object> get props => [providerData];
}

class GetAllServiceProviderFailed extends ServiceProviderState {
  final String? error;

  const GetAllServiceProviderFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class BookingSuccessfully extends ServiceProviderState {
  final List<ProviderData> providerData;

  const BookingSuccessfully(this.providerData);

  @override
  List<Object> get props => [providerData];
}

class BookingFailed extends ServiceProviderState {
  final String error;
  final List<ProviderData> providerData;

  const BookingFailed(this.error,this.providerData);

  @override
  List<Object?> get props => [providerData,error];
}
