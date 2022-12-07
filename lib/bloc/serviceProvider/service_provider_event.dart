// ignore_for_file: non_constant_identifier_names

part of 'service_provider_bloc.dart';

abstract class ServiceProviderEvent extends Equatable {
  const ServiceProviderEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryList extends ServiceProviderEvent {}

class AllServiceProviderList extends ServiceProviderEvent {
  const AllServiceProviderList({
    this.name = "",
    this.catId = "",
    this.rating = "",
    this.location = const <String, dynamic>{},
  });

  final String name;
  final String catId;
  final String rating;
  final Map<String, dynamic> location;
}

class BookService extends ServiceProviderEvent {
  const BookService(this.amount, this.date, this.address_lat, this.address_long, this.gstAmount, this.time, this.serviceCatId, this.serviceProviderId);

  final String? amount;
  final String? date;
  final String? address_lat;
  final String? address_long;
  final String? gstAmount;
  final String? time;
  final List<String>? serviceCatId;
  final String serviceProviderId;
}
