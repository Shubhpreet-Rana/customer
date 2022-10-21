part of 'service_provider_bloc.dart';

abstract class ServiceProviderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCategoryList extends ServiceProviderEvent {}

class AllServiceProviderList extends ServiceProviderEvent {
  AllServiceProviderList(this.name, this.catid, this.rating, this.location);

  final String? name;
  final String? catid;
  final String? rating;
  Map<String, dynamic>? location;
}

class BookService extends ServiceProviderEvent {
  BookService(this.amount, this.date, this.address_lat, this.address_long, this.gst_amount, this.time, this.service_cat_id);

  final String? amount;
  final String? date;
  final String? address_lat;
  final String? address_long;
  final String? gst_amount;
  final String? time;
  final List<String>? service_cat_id;
}
