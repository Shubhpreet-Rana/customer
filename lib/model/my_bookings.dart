// To parse this JSON data, do
//
//     final myBooking = myBookingFromJson(jsonString);

import 'dart:convert';

MyBooking myBookingFromJson(String str) => MyBooking.fromJson(json.decode(str));

String myBookingToJson(MyBooking data) => json.encode(data.toJson());

class MyBooking {
  MyBooking({
    this.status,
    this.isLastPage,
    this.message,
    this.data,
  });

  int? status;
  int? isLastPage;
  String? message;
  List<MyBookingData>? data;

  factory MyBooking.fromJson(Map<String, dynamic> json) => MyBooking(
    status: json["status"],
    isLastPage: json["is_last_page"],
    message: json["message"],
    data: List<MyBookingData>.from(json["data"].map((x) => MyBookingData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "is_last_page": isLastPage,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MyBookingData {
  MyBookingData({
    this.id,
    this.businessName,
    this.image1,
    this.amount,
    this.gstAmount,
    this.addressLat,
    this.addressLong,
    this.date,
    this.time,
    this.bookingStatus,
    this.serviceCatId,
    this.services,
  });

  int? id;
  String? businessName;
  String? image1;
  String? amount;
  String? gstAmount;
  String? addressLat;
  String? addressLong;
  DateTime? date;
  String? time;
  int? bookingStatus;
  String? serviceCatId;
  List<Service>? services;

  factory MyBookingData.fromJson(Map<String, dynamic> json) => MyBookingData(
    id: json["id"],
    businessName: json["business_name"],
    image1: json["image1"],
    amount: json["amount"],
    gstAmount: json["gst_amount"],
    addressLat: json["address_lat"] == null ? null : json["address_lat"],
    addressLong: json["address_long"] == null ? null : json["address_long"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    bookingStatus: json["booking_status"],
    serviceCatId: json["service_cat_id"],
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_name": businessName,
    "image1": image1,
    "amount": amount,
    "gst_amount": gstAmount,
    "address_lat": addressLat == null ? null : addressLat,
    "address_long": addressLong == null ? null : addressLong,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "time": time,
    "booking_status": bookingStatus,
    "service_cat_id": serviceCatId,
    "services": List<dynamic>.from(services!.map((x) => x.toJson())),
  };
}

class Service {
  Service({
    this.serviceCategory,
    this.description,
    this.type,
    this.brand,
    this.price,
  });

  String? serviceCategory;
  String? description;
  String? type;
  String? brand;
  String? price;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    serviceCategory: json["service_category"],
    description: json["description"],
    type: json["type"],
    brand: json["brand"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "service_category": serviceCategory,
    "description": description,
    "type": type,
    "brand": brand,
    "price": price,
  };
}
