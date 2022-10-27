// ignore_for_file: non_constant_identifier_names

part of 'add_car_bloc.dart';

abstract class SellCarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddCarToSell extends SellCarEvent {
  final  String? brandName;
  final  String? modelName;
  final  String? capacity;
  final  String? carImage_1;
  final  String? carImage_2;
  final  String? carImage_3;
  final  String? color;
  final  String? description;
  final  String? mileage;
  final  String? manufacturingYear;
  final  String? address;
  final  double? address_lat;
  final  double? address_long;
  final  String? price;

  AddCarToSell(
      {this.brandName,
      this.modelName,
      this.capacity,
      this.carImage_1,
      this.carImage_2,
      this.carImage_3,
      this.color,
      this.description,
      this.mileage,
      this.manufacturingYear,
      this.address,
      this.address_lat,
      this.address_long,
      this.price});
}

class UpdateCarToSell extends SellCarEvent {
  final String? brandName;
  final String? modelName;
  final String? capacity;
  final String? carImage_1;
  final String? carImage_2;
  final String? carImage_3;
  final String? color;
  final String? description;
  final String? mileage;
  final String? manufacturingYear;
  final String? address;
  final double? address_lat;
  final double? address_long;
  final String? price;
  final int? id;

  UpdateCarToSell(
      {this.brandName,
      this.modelName,
      this.capacity,
      this.carImage_1,
      this.carImage_2,
      this.carImage_3,
      this.color,
      this.description,
      this.mileage,
      this.manufacturingYear,
      this.address,
      this.address_lat,
      this.address_long,
      this.price,
      this.id});
}

class Select1Image extends SellCarEvent {
  final BuildContext context;

  Select1Image(this.context);
}

class Select2Image extends SellCarEvent {
  final BuildContext context;

  Select2Image(this.context);
}

class Select3Image extends SellCarEvent {
  final BuildContext context;

  Select3Image(this.context);
}
