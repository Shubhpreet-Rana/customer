// To parse this JSON data, do
//
//     final getCategoryList = getCategoryListFromJson(jsonString);

import 'dart:convert';

CategoryList getCategoryListFromJson(String str) => CategoryList.fromJson(json.decode(str));

String getCategoryListToJson(CategoryList data) => json.encode(data.toJson());

class CategoryList {
  CategoryList({
    this.status,
    this.message,
    this.serviceCategory,
  });

  int? status;
  String? message;
  List<ServiceCategoryData>? serviceCategory;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    status: json["status"],
    message: json["message"],
    serviceCategory: List<ServiceCategoryData>.from(json["service_category"].map((x) => ServiceCategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "service_category": List<dynamic>.from(serviceCategory!.map((x) => x.toJson())),
  };
}

class ServiceCategoryData {
  ServiceCategoryData({
    this.id,
    this.serviceCategory,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? serviceCategory;
  String? createdAt;
  dynamic? updatedAt;

  factory ServiceCategoryData.fromJson(Map<String, dynamic> json) => ServiceCategoryData(
    id: json["id"],
    serviceCategory: json["service_category"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_category": serviceCategory,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
