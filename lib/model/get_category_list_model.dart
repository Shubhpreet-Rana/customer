// To parse this JSON data, do
//
//     final getCategoryList = getCategoryListFromJson(jsonString);

import 'dart:convert';

GetCategoryList getCategoryListFromJson(String str) => GetCategoryList.fromJson(json.decode(str));

String getCategoryListToJson(GetCategoryList data) => json.encode(data.toJson());

class GetCategoryList {
  GetCategoryList({
    this.status,
    this.message,
    this.serviceCategory,
  });

  int? status;
  String? message;
  List<CategoryList>? serviceCategory;

  factory GetCategoryList.fromJson(Map<String, dynamic> json) => GetCategoryList(
        status: json["status"],
        message: json["message"],
        serviceCategory: List<CategoryList>.from(json["service_category"].map((x) => CategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "service_category": List<dynamic>.from(serviceCategory!.map((x) => x.toJson())),
      };
}

class CategoryList {
  CategoryList({
    this.id,
    this.serviceCategory,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? serviceCategory;
  DateTime? createdAt;
  dynamic updatedAt;

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["id"],
        serviceCategory: json["service_category"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_category": serviceCategory,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}
