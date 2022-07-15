// To parse this JSON data, do
//
//     final getServiceProviderList = getServiceProviderListFromJson(jsonString);

import 'dart:convert';

GetServiceProviderList getServiceProviderListFromJson(String str) =>
    GetServiceProviderList.fromJson(json.decode(str));

String getServiceProviderListToJson(GetServiceProviderList data) =>
    json.encode(data.toJson());

class GetServiceProviderList {
  GetServiceProviderList({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<ProviderData>? data;

  factory GetServiceProviderList.fromJson(Map<String, dynamic> json) =>
      GetServiceProviderList(
        status: json["status"],
        message: json["message"],
        data: List<ProviderData>.from(
            json["data"].map((x) => ProviderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProviderData {
  ProviderData({
    this.profile,
    this.serviceCategory,
  });

  Profile? profile;
  ServiceCategory? serviceCategory;

  factory ProviderData.fromJson(Map<String, dynamic> json) => ProviderData(
        profile: Profile.fromJson(json["profile"]),
        serviceCategory: ServiceCategory.fromJson(json["service_category"]),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile!.toJson(),
        "service_category": serviceCategory!.toJson(),
      };
}

class Profile {
  Profile({
    this.userImage,
    this.businessName,
    this.websiteLink,
    this.image1,
    this.image2,
    this.image3,
    this.experience,
    this.address,
    this.addressLat,
    this.addressLong,
    this.joinDate,
    this.rating,
  });

  String? userImage;
  String? businessName;
  String? websiteLink;
  String? image1;
  String? image2;
  String? image3;
  String? experience;
  String? address;
  double? addressLat;
  double? addressLong;
  String? joinDate;
  String? rating;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
      userImage: json["user_image"],
      businessName: json["business_name"],
      websiteLink: json["website_link"],
      image1: json["image1"],
      image2: json["image2"],
      image3: json["image3"],
      experience: json["experience"],
      address: json["address"],
      addressLat: json["address_lat"].toDouble(),
      addressLong: json["address_long"].toDouble(),
      joinDate: json['join_date'],
      rating: json['rating']);

  Map<String, dynamic> toJson() => {
        "user_image": userImage,
        "business_name": businessName,
        "website_link": websiteLink,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "experience": experience,
        "address": address,
        "address_lat": addressLat,
        "address_long": addressLong,
        "join_date": joinDate,
        "rating": rating,
      };
}

class ServiceCategory {
  ServiceCategory({
    this.oilChange,
    this.gasoline,
    this.carWash,
    this.autoRepair,
    this.autoParts,
    this.roadSideAssistance,
  });

  Gasoline? oilChange;
  Gasoline? gasoline;
  CarWash? carWash;
  RoadSideAssistance? autoRepair;
  RoadSideAssistance? autoParts;
  RoadSideAssistance? roadSideAssistance;

  factory ServiceCategory.fromJson(Map<String, dynamic> json) =>
      ServiceCategory(
        oilChange: json["Oil Change"] == null
            ? null
            : Gasoline.fromJson(json["Oil Change"]),
        gasoline: json["Gasoline"] == null
            ? null
            : Gasoline.fromJson(json["Gasoline"]),
        carWash: json["Car Wash"] == null
            ? null
            : CarWash.fromJson(json["Car Wash"]),
        autoRepair: json["Auto Repair"] == null
            ? null
            : RoadSideAssistance.fromJson(json["Auto Repair"]),
        autoParts: json["Auto Parts"] == null
            ? null
            : RoadSideAssistance.fromJson(json["Auto Parts"]),
        roadSideAssistance:
            RoadSideAssistance.fromJson(json["Road Side Assistance"]),
      );

  Map<String, dynamic> toJson() => {
        "Oil Change": oilChange == null ? null : oilChange!.toJson(),
        "Gasoline": gasoline == null ? null : gasoline!.toJson(),
        "Car Wash": carWash == null ? null : carWash!.toJson(),
        "Auto Repair": autoRepair == null ? null : autoRepair!.toJson(),
        "Auto Parts": autoParts == null ? null : autoParts!.toJson(),
        "Road Side Assistance": roadSideAssistance!.toJson(),
      };
}

class RoadSideAssistance {
  RoadSideAssistance({
    this.catId,
    this.description,
    this.price,
    this.availability,
  });

  int? catId;
  String? description;
  String? price;
  String? availability;

  factory RoadSideAssistance.fromJson(Map<String, dynamic> json) =>
      RoadSideAssistance(
        catId: json["cat_id"],
        description: json["description"],
        price: json["price"],
        availability: json["availability"],
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "description": description,
        "price": price,
        "availability": availability,
      };
}

class CarWash {
  CarWash({
    this.catId,
    this.description,
    this.type,
    this.price,
    this.availability,
  });

  int? catId;
  String? description;
  String? type;
  String? price;
  String? availability;

  factory CarWash.fromJson(Map<String, dynamic> json) => CarWash(
        catId: json["cat_id"],
        description: json["description"],
        type: json["type"],
        price: json["price"],
        availability: json["availability"],
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "description": description,
        "type": type,
        "price": price,
        "availability": availability,
      };
}

class Gasoline {
  Gasoline({
    this.catId,
    this.description,
    this.type,
    this.brand,
    this.price,
    this.availability,
  });

  int? catId;
  String? description;
  String? type;
  String? brand;
  String? price;
  String? availability;

  factory Gasoline.fromJson(Map<String, dynamic> json) => Gasoline(
        catId: json["cat_id"],
        description: json["description"],
        type: json["type"],
        brand: json["brand"],
        price: json["price"],
        availability: json["availability"],
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "description": description,
        "type": type,
        "brand": brand,
        "price": price,
        "availability": availability,
      };
}
