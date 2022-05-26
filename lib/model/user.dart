// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.status,
    this.message,
    this.user,
  });

  int? status;
  String? message;
  UserClass? user;

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        message: json["message"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user!.toJson(),
      };
}

class UserClass {
  UserClass({
    this.id,
    this.firstName,
    this.lastName,
    this.userType,
    this.email,
    this.userImage,
    this.gender,
    this.mobile,
    this.address,
    this.emailVerifiedAt,
    this.otp,
    this.apiToken,
    this.screen,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? firstName;
  String? lastName;
  int? userType;
  String? email;
  String? userImage;
  int? gender;
  String? mobile;
  String? address;
  DateTime? emailVerifiedAt;
  int? otp;
  String? apiToken;
  String? screen;
  DateTime? createdAt;
  DateTime? updatedAt;

  String get getGenderText {
    if (gender == 1) {
      return "Male";
    } else if (gender == 2) {
      return "Female";
    } else {
      return "Other";
    }
  }

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userType: json["user_type"],
        email: json["email"],
        userImage: json["user_image"],
        gender: json["gender"],
        mobile: json["mobile"],
        address: json["address"],
        emailVerifiedAt: json["email_verified_at"],
        otp: json["otp"],
        apiToken: json["api_token"],
        screen: json["screen"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "user_type": userType,
        "email": email,
        "user_image": userImage,
        "gender": gender,
        "mobile": mobile,
        "address": address,
        "email_verified_at": emailVerifiedAt,
        "otp": otp,
        "api_token": apiToken,
        "screen": screen,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
