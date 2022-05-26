// To parse this JSON data, do
//
//     final vehicles = vehiclesFromJson(jsonString);

import 'dart:convert';

Vehicles vehiclesFromJson(String str) => Vehicles.fromJson(json.decode(str));

String vehiclesToJson(Vehicles data) => json.encode(data.toJson());

class Vehicles {
  Vehicles({
    this.status,
    this.message,
    this.vehicle,
  });

  int? status;
  String? message;
  List<Vehicle>? vehicle;

  factory Vehicles.fromJson(Map<String, dynamic> json) => Vehicles(
        status: json["status"],
        message: json["message"],
        vehicle: List<Vehicle>.from(json["vehicle"].map((x) => Vehicle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "vehicle": List<dynamic>.from(vehicle!.map((x) => x.toJson())),
      };
}

class Vehicle {
  Vehicle({
    this.id,
    this.userId,
    this.brandName,
    this.model,
    this.engineCapacity,
    this.carImage1,
    this.carImage2,
    this.carImage3,
    this.color,
    this.description,
    this.mileage,
    this.price,
    this.dateOfService,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? brandName;
  String? model;
  String? engineCapacity;
  String? carImage1;
  String? carImage2;
  String? carImage3;
  String? color;
  String? description;
  String? mileage;
  String? price;
  String? dateOfService;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        userId: json["user_id"],
        brandName: json["brand_name"],
        model: json["model"],
        engineCapacity: json["engine_capacity"],
        carImage1: json["car_image_1"],
        carImage2: json["car_image_2"],
        carImage3: json["car_image_3"],
        color: json["color"],
        description: json["description"],
        mileage: json["mileage"],
        price: json["price"],
        dateOfService: json["date_of_service"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "brand_name": brandName,
        "model": model,
        "engine_capacity": engineCapacity,
        "car_image_1": carImage1,
        "car_image_2": carImage2,
        "car_image_3": carImage3,
        "color": color,
        "description": description,
        "mileage": mileage,
        "price": price,
        "date_of_service": dateOfService,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
