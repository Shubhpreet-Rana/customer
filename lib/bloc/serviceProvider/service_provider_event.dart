part of 'service_provider_bloc.dart';

abstract class ServiceProviderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCategoryList extends ServiceProviderEvent {
}
class AllServiceProviderList extends ServiceProviderEvent{
  AllServiceProviderList(this.name, this.catid);

  final String? name;
  final String? catid;
}





