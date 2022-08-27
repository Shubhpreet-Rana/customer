// To parse this JSON data, do
//
//     final getBanner = getBannerFromJson(jsonString);

import 'dart:convert';

Banners getBannerFromJson(String str) => Banners.fromJson(json.decode(str));

String getBannerToJson(Banners data) => json.encode(data.toJson());

class Banners {
  Banners({
    this.status,
    this.message,
    this.data,
  });

  int? status;
  String? message;
  BannerData? data;

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
    status: json["status"],
    message: json["message"],
    data: BannerData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class BannerData {
  BannerData({
    this.id,
    this.topImage,
    this.bottomImage,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? topImage;
  String? bottomImage;
  dynamic title;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
    id: json["id"],
    topImage: json["top_image"],
    bottomImage: json["bottom_image"],
    title: json["title"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "top_image": topImage,
    "bottom_image": bottomImage,
    "title": title,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
