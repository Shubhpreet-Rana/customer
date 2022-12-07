// ignore_for_file: file_names

import 'dart:convert';

// To parse this JSON data, do
//
//     final getServiceProviderList = getServiceProviderListFromJson(jsonString);

GetServiceProviderList getServiceProviderListFromJson(String str) => GetServiceProviderList.fromJson(json.decode(str));

String getServiceProviderListToJson(GetServiceProviderList data) => json.encode(data.toJson());

class GetServiceProviderList {
  GetServiceProviderList({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  List<ProviderData>? data;

  factory GetServiceProviderList.fromJson(Map<String, dynamic> json) => GetServiceProviderList(
        status: json["status"],
        message: json["message"],
        data: List<ProviderData>.from(json["data"].map((x) => ProviderData.fromJson(x))),
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
        "profile": profile?.toJson(),
        "service_category": serviceCategory?.toJson(),
      };
}

class Profile {
  Profile(
      {this.userImage,
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
      required this.userId});

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
  final int userId;

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
      joinDate: json["join_date"],
      rating: json["rating"],
      userId: json['user_id']);

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

  AutoParts? oilChange;
  AutoParts? gasoline;
  AutoParts? carWash;
  AutoParts? autoRepair;
  AutoParts? autoParts;
  AutoParts? roadSideAssistance;

  factory ServiceCategory.fromJson(Map<String, dynamic> json) => ServiceCategory(
        oilChange: json["Oil Change"] == null ? null : AutoParts.fromJson(json["Oil Change"]),
        gasoline: json["Gasoline"] == null ? null : AutoParts.fromJson(json["Gasoline"]),
        carWash: json["Car Wash"] == null ? null : AutoParts.fromJson(json["Car Wash"]),
        autoRepair: json["Auto Repair"] == null ? null : AutoParts.fromJson(json["Auto Repair"]),
        autoParts: json["Auto Parts"] == null ? null : AutoParts.fromJson(json["Auto Parts"]),
        roadSideAssistance: json["Road Side Assistance"] == null ? null : AutoParts.fromJson(json["Road Side Assistance"]),
      );

  Map<String, dynamic> toJson() => {
        "Oil Change": oilChange?.toJson(),
        "Gasoline": gasoline?.toJson(),
        "Car Wash": carWash?.toJson(),
        "Auto Repair": autoRepair?.toJson(),
        "Auto Parts": autoParts?.toJson(),
        "Road Side Assistance": roadSideAssistance?.toJson(),
      };
}

class AutoParts {
  AutoParts({
    this.catId,
    this.description,
    this.price,
    this.availability,
    this.gstRate,
    this.type,
    this.brand,
  });

  int? catId;
  String? description;
  String? price;
  String? availability;
  int? gstRate;
  String? type;
  String? brand;

  factory AutoParts.fromJson(Map<String, dynamic> json) => AutoParts(
        catId: json["cat_id"],
        description: json["description"],
        price: json["price"],
        availability: json["availability"],
        gstRate: json["gst_rate"],
        type: json["type"],
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "description": description,
        "price": price,
        "availability": availability,
        "gst_rate": gstRate,
        "type": type,
        "brand": brand,
      };
}
