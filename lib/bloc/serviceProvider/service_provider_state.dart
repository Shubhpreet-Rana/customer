part of 'service_provider_bloc.dart';

abstract class ServiceProviderState extends Equatable {}

class Loading extends ServiceProviderState {
  @override
  List<Object?> get props => [];
}
class CarScreenLoading extends ServiceProviderState {
  @override
  List<Object?> get props => [];
}

class CategoryListFetchSuccessfully extends ServiceProviderState {
  List<ServiceCategoryData> serviceCategory;

  CategoryListFetchSuccessfully(this.serviceCategory):super();

  @override
  List<Object> get props => [serviceCategory];
}

class CategoryListFailed extends ServiceProviderState {
  final String? error;

  CategoryListFailed(this.error);

  @override
  List<Object?> get props => [error];
}

class GetAllServiceProviderFetchSuccessfully extends ServiceProviderState {
  List<ProviderData> providerData;

  GetAllServiceProviderFetchSuccessfully(this.providerData):super();

  @override
  List<Object> get props => [providerData];
}
class  GetAllServiceProviderFailed extends ServiceProviderState {
  final String? error;

  GetAllServiceProviderFailed(this.error);

  @override
  List<Object?> get props => [error];
}
