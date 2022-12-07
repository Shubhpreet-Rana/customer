class MyBooking {
  const MyBooking({
    required this.status,
    this.isLastPage = 0,
    required this.message,
    this.data = const [],
  });

  final int status;
  final int isLastPage;
  final String message;
  final List<MyBookingData> data;

  factory MyBooking.fromJson(Map<String, dynamic> json) => MyBooking(
        status: json["status"],
        isLastPage: json["is_last_page"],
        message: json["message"],
        data: List<MyBookingData>.from(
          json["data"].map(
            (x) => MyBookingData.fromJson(x),
          ),
        ),
      );
}

class MyBookingData {
  MyBookingData(
      {this.id,
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
      this.services = const[],
      this.rating,
      this.description,
      required this.userId});

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
  String? rating;
  List<Service> services;
  String? description;
  final int userId;

  factory MyBookingData.fromJson(Map<String, dynamic> json) => MyBookingData(
      id: json["id"],
      businessName: json["business_name"],
      image1: json["image1"],
      amount: json["amount"],
      gstAmount: json["gst_amount"],
      addressLat: json["address_lat"],
      addressLong: json["address_long"],
      date: DateTime.parse(json["date"]),
      time: json["time"],
      rating: json["rating"],
      bookingStatus: json["booking_status"],
      serviceCatId: json["service_cat_id"],
      services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
      description: json['description'],
      userId: json['user_id']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_name": businessName,
        "image1": image1,
        "amount": amount,
        "rating": rating,
        "gst_amount": gstAmount,
        "address_lat": addressLat,
        "address_long": addressLong,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "booking_status": bookingStatus,
        "service_cat_id": serviceCatId,
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
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
