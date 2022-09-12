part of 'add_car_bloc.dart';

abstract class SellCarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddCarToSell extends SellCarEvent {
  String? brand_name;
  String? model_name;
  String? capacity;
  String? car_image_1;
  String? car_image_2;
  String? car_image_3;
  String? color;
  String? description;
  String? mileage;
  String? manufacturing_year;
  String? address;
  String? address_lat;
  String? address_long;
  String? price;

  AddCarToSell(
      {this.brand_name,
      this.model_name,
      this.capacity,
      this.car_image_1,
      this.car_image_2,
      this.car_image_3,
      this.color,
      this.description,
      this.mileage,
      this.manufacturing_year,
      this.address,
      this.address_lat,
      this.address_long,
      this.price});
}
