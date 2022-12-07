// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:app/common/constants.dart';
import 'package:app/common/methods/custom_storage.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../../common/services/getit.dart';
import '../endpoints/endpoints.dart';
import '../network/dio_client.dart';
import '../network/exceptions.dart';

class HomeRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> getBanners() async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      final response = await netWorkLocator.dio.get(
        EndPoints.banner,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to sign in');
      }

      completer.complete(response.data);
    } catch (e) {
      Map<String, dynamic> error = {"message": "failed", "status": 0};
      if (e is DioError) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        error.update("message", (value) => errorMessage);
        completer.complete(error);
      } else {
        completer.complete(error);
      }
    }
    return completer.future;
  }

  Future<Map<String, dynamic>> getAllVehicle(String page) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      final url = "${EndPoints.marketallvehicle}?page=$page&per_page=20";
      final response = await netWorkLocator.dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to sign in');
      }

      completer.complete(response.data);
    } catch (e) {
      Map<String, dynamic> error = {"message": "failed", "status": 0};
      if (e is DioError) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        error.update("message", (value) => errorMessage);
        completer.complete(error);
      } else {
        completer.complete(error);
      }
    }
    return completer.future;
  }

  Future<Map<String, dynamic>> getMyMarketVehicle(String page) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      final url = "${EndPoints.marketVehicle}?page=$page&per_page=20";
      final response = await netWorkLocator.dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to sign in');
      }

      completer.complete(response.data);
    } catch (e) {
      Map<String, dynamic> error = {"message": "failed", "status": 0};
      if (e is DioError) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        error.update("message", (value) => errorMessage);
        completer.complete(error);
      } else {
        completer.complete(error);
      }
    }
    return completer.future;
  }

  Future<Map<String, dynamic>> sellCarVehicle(
      {String? brandName,
      String? modelName,
      String? capacity,
      String? carImage_1,
      String? carImage_2,
      String? carImage_3,
      String? color,
      String? description,
      String? mileage,
      String? manufacturingYear,
      String? address,
      double? address_lat,
      double? address_long,
      String? price}) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];
      final mimeTypeData1 = lookupMimeType(carImage_1!, headerBytes: [0xFF, 0xD8])?.split('/');
      final mimeTypeData2 = lookupMimeType(carImage_2!, headerBytes: [0xFF, 0xD8])?.split('/');
      final mimeTypeData3 = lookupMimeType(carImage_3!, headerBytes: [0xFF, 0xD8])?.split('/');
      FormData formData = FormData.fromMap({
        'model_name': modelName!,
        'brand_name': brandName,
        'capacity': capacity!,
        'color': color!,
        'description': description,
        'mileage': mileage,
        'manufacturing_year': manufacturingYear,
        'address': address,
        'address_lat': address_lat,
        'address_long': address_long,
        'price': price,
        'car_image_1': MultipartFile.fromFileSync(carImage_1, contentType: MediaType(mimeTypeData1![0], mimeTypeData1[1]), filename: basename(carImage_1)),
        'car_image_2': carImage_2.isNotEmpty ? MultipartFile.fromFileSync(carImage_2, contentType: MediaType(mimeTypeData2![0], mimeTypeData2[1]), filename: basename(carImage_2)) : null,
        'car_image_3': carImage_3.isNotEmpty ? MultipartFile.fromFileSync(carImage_3, contentType: MediaType(mimeTypeData3![0], mimeTypeData3[1]), filename: basename(carImage_3)) : null,
      });
      Map<String, String> headers = {"Accept": "application/json", "Authorization": "Bearer $token", "Content-Type": "multipart/form-data; boundary=<calculated when request is sent>"};
      const String url = EndPoints.addmarketvehicle;
      final response = await netWorkLocator.dio.post(
        url,
        data: formData,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to sign in');
      }

      completer.complete(response.data);
    } catch (e) {
      Map<String, dynamic> error = {"message": "failed", "status": 0};
      if (e is DioError) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        error.update("message", (value) => errorMessage);
        completer.complete(error);
      } else {
        completer.complete(error);
      }
    }
    return completer.future;
  }

  Future<Map<String, dynamic>> updateCarVehicle(
      {String? brand_name,
      String? model_name,
      String? capacity,
      String? car_image_1,
      String? car_image_2,
      String? car_image_3,
      String? color,
      String? description,
      String? mileage,
      String? manufacturing_year,
      String? address,
      double? address_lat,
      double? address_long,
      int? id,
      String? price}) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    List<String>? imagePath1, imagePath2, imagePath3;
    try {
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];
      if (car_image_1 != null && car_image_1 != "") {
        imagePath1 = lookupMimeType(car_image_1, headerBytes: [0xFF, 0xD8])?.split('/');
      }
      if (car_image_2 != null && car_image_2 != "") {
        imagePath2 = lookupMimeType(car_image_2, headerBytes: [0xFF, 0xD8])?.split('/');
      }
      if (car_image_3 != null && car_image_3 != "") {
        imagePath3 = lookupMimeType(car_image_3, headerBytes: [0xFF, 0xD8])?.split('/');
      }

      FormData formData = FormData.fromMap({
        'model_name': model_name!,
        'brand_name': brand_name,
        'capacity': capacity!,
        'color': color!,
        'description': description,
        'mileage': mileage,
        'manufacturing_year': manufacturing_year,
        'address': address,
        'address_lat': address_lat,
        'address_long': address_long,
        'price': price,
/*        'car_image_1': MultipartFile.fromFileSync(car_image_1, contentType: MediaType(mimeTypeData1![0], mimeTypeData1[1]), filename: basename(car_image_1)),
        'car_image_2': car_image_2.isNotEmpty ? MultipartFile.fromFileSync(car_image_2, contentType: MediaType(mimeTypeData2![0], mimeTypeData2[1]), filename: basename(car_image_2)) : null,
        'car_image_3': car_image_3.isNotEmpty ? MultipartFile.fromFileSync(car_image_3, contentType: MediaType(mimeTypeData3![0], mimeTypeData3[1]), filename: basename(car_image_3)) : null,*/
      });
      if (imagePath1 != null && imagePath1.isNotEmpty) {
        formData.files.add(MapEntry("car_image_1", MultipartFile.fromFileSync(car_image_1!, contentType: MediaType(imagePath1[0], imagePath1[1]), filename: basename(car_image_1))));
      }
      if (imagePath2 != null && imagePath2.isNotEmpty) {
        formData.files.add(MapEntry("car_image_2", MultipartFile.fromFileSync(car_image_2!, contentType: MediaType(imagePath2[0], imagePath2[1]), filename: basename(car_image_2))));
      }
      if (imagePath3 != null && imagePath3.isNotEmpty) {
        formData.files.add(MapEntry("car_image_3", MultipartFile.fromFileSync(car_image_3!, contentType: MediaType(imagePath3[0], imagePath3[1]), filename: basename(car_image_3))));
      }
      Map<String, String> headers = {"Accept": "application/json", "Authorization": "Bearer $token", "Content-Type": "multipart/form-data; boundary=<calculated when request is sent>"};
      final url = "${EndPoints.editmarketvehicle}?id=$id";
      final response = await netWorkLocator.dio.post(
        url,
        data: formData,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to sign in');
      }

      completer.complete(response.data);
    } catch (e) {
      Map<String, dynamic> error = {"message": "failed", "status": 0};
      if (e is DioError) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        error.update("message", (value) => errorMessage);
        completer.complete(error);
      } else {
        completer.complete(error);
      }
    }
    return completer.future;
  }
}
