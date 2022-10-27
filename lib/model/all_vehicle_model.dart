// To parse this JSON data, do
//
//     final allVehicel = allVehicelFromJson(jsonString);

import 'dart:convert';

AllVehicel allVehicelFromJson(String str) => AllVehicel.fromJson(json.decode(str));

String allVehicelToJson(AllVehicel data) => json.encode(data.toJson());

class AllVehicel {
  AllVehicel({
    this.status,
    this.isLastPage,
    this.message,
    this.vehicle,
  });

  int? status;
  int? isLastPage;
  String? message;
  List<AllVehicleData>? vehicle;

  factory AllVehicel.fromJson(Map<String, dynamic> json) => AllVehicel(
    status: json["status"],
    isLastPage: json["is_last_page"],
    message: json["message"],
    vehicle: List<AllVehicleData>.from(json["vehicle"].map((x) => AllVehicleData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "is_last_page": isLastPage,
    "message": message,
    "vehicle": List<dynamic>.from(vehicle!.map((x) => x.toJson())),
  };
}

class AllVehicleData {
  AllVehicleData({
    this.id,
    this.brandName,
    this.modelName,
    this.description,
    this.price,
    this.userId,
    this.color,
    this.mileage,
    this.capacity,
    this.manufacturingYear,
    this.address,
    this.addressLat,
    this.addressLong,
    this.carImage1,
    this.carImage2,
    this.carImage3,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? brandName;
  String? modelName;
  String? description;
  String? price;
  int? userId;
  String? color;
  String? mileage;
  int? capacity;
  String? manufacturingYear;
  String? address;
  String? addressLat;
  String? addressLong;
  String? carImage1;
  String? carImage2;
  String? carImage3;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AllVehicleData.fromJson(Map<String, dynamic> json) => AllVehicleData(
    id: json["id"],
    brandName: json["brand_name"],
    modelName: json["model_name"],
    description: json["description"],
    price: json["price"],
    userId: json["user_id"],
    color: json["color"],
    mileage: json["mileage"],
    capacity: json["capacity"],
    manufacturingYear: json["manufacturing_year"],
    address: json["address"],
    addressLat: json["address_lat"],
    addressLong: json["address_long"],
    carImage1: json["car_image_1"],
    carImage2: json["car_image_2"],
    carImage3: json["car_image_3"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand_name": brandName,
    "model_name": modelName,
    "description": description,
    "price": price,
    "user_id": userId,
    "color": color,
    "mileage": mileage,
    "capacity": capacity,
    "manufacturing_year": manufacturingYear,
    "address": address,
    "address_lat": addressLat,
    "address_long": addressLong,
    "car_image_1": carImage1,
    "car_image_2": carImage2,
    "car_image_3": carImage3,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
