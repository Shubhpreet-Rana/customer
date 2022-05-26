import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../../common/constants.dart';
import '../../common/methods/custom_storage.dart';
import '../../common/services/getit.dart';
import '../../model/vehicle.dart';
import '../../screens/vehicle/vehicle_details.dart';
import '../endpoints/endpoints.dart';
import '../network/dio_client.dart';
import '../network/exceptions.dart';

class VehicleRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> addVehicle({
    required Car car,
  }) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
    String token = userInfo['token'];
    final mimeTypeData1 = lookupMimeType(car.image1!, headerBytes: [0xFF, 0xD8])?.split('/');
    final mimeTypeData2 = lookupMimeType(car.image2!, headerBytes: [0xFF, 0xD8])?.split('/');
    final mimeTypeData3 = lookupMimeType(car.image3!, headerBytes: [0xFF, 0xD8])?.split('/');
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data; boundary=<calculated when request is sent>"
      };
      FormData formData = FormData.fromMap({
        'brand_name': car.brand,
        'model': car.model,
        'engine_capacity': car.engine,
        'color': car.color,
        'mileage': car.mileage,
        'description': car.description,
        'date_of_service': car.dateOfService,
        'price': car.price,
        'car_image_1': MultipartFile.fromFileSync(car.image1!,
            contentType: MediaType(mimeTypeData1![0], mimeTypeData1[1]), filename: basename(car.image1!)),
        'car_image_2': MultipartFile.fromFileSync(car.image2!,
            contentType: MediaType(mimeTypeData2![0], mimeTypeData2[1]), filename: basename(car.image2!)),
        'car_image_3': MultipartFile.fromFileSync(car.image3!,
            contentType: MediaType(mimeTypeData3![0], mimeTypeData3[1]), filename: basename(car.image3!)),
      });
      netWorkLocator.dio.options.connectTimeout = 500000;
      netWorkLocator.dio.options.receiveTimeout = 1000000;

      final response = await netWorkLocator.dio.post('${EndPoints.baseUrl}${EndPoints.addVehicle}',
          data: formData,
          options: Options(
            headers: headers,
          ));
      if (response.statusCode != 200) {
        throw Exception('Failed to sign up');
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

  Future<Vehicles?> getUserVehiclesDetails() async {
    var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
    String token = userInfo['token'];
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      final response = await netWorkLocator.dio.get(
        '${EndPoints.baseUrl}${EndPoints.getVehicle}',
        options: Options(
          headers: headers,
        ),
      );
      return Vehicles.fromJson(response.data);
    } catch (e) {
      Map<String, dynamic> error = {"message": "failed", "status": 0};
      if (e is DioError) {
        final errorMessage = DioExceptions.fromDioError(e).toString();
        error.update("message", (value) => errorMessage);
      } else {}
      return null;
    }
  }
}
