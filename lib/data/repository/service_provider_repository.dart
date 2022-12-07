// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:app/common/constants.dart';
import 'package:app/common/methods/custom_storage.dart';
import 'package:app/common/services/getit.dart';
import 'package:app/data/endpoints/endpoints.dart';
import 'package:app/data/network/dio_client.dart';
import 'package:app/data/network/exceptions.dart';
import 'package:dio/dio.dart';

class ServiceProviderRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> getCategoryList() async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      final response = await netWorkLocator.dio.get(
        EndPoints.getCategoryList,
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

  Future<Map<String, dynamic>> getAllServiceProvider({String? categoryName, String? catid, String? rating, Map<String, dynamic>? location}) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      Map<String, dynamic> mapData = {};
      if (categoryName != null && categoryName != "") {
        mapData.putIfAbsent("business_name", () => categoryName);
      }
      if (catid != null && catid != "") {
        mapData.putIfAbsent("cat_id", () => catid);
      }
      if (rating != null && rating != "") {
        mapData.putIfAbsent("rating", () => rating);
      }
      if (location!.isNotEmpty) {
        if (location.containsKey("lat")) {
          mapData.putIfAbsent("address_lat", () => location['lat']);
        }
        if (location.containsKey("long")) {
          mapData.putIfAbsent("address_long", () => location['long']);
        }
      }
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      String url = EndPoints.getProviderList;
      final response = await netWorkLocator.dio.get(
        url,
        options: Options(
          headers: headers,
        ),
        // queryParameters: mapData,
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

  Future<Map<String, dynamic>> bookService(
      {String? amount, String? date, String? address_lat, String? address_long, String? gst_amount, String? time, List<String>? service_cat_id, required String serviceProviderId}) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();

    try {
      String serviceCatIds = "";
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];

      if (service_cat_id!.isNotEmpty) {
        if (service_cat_id.length == 1) {
          serviceCatIds = service_cat_id[0];
        } else {
          serviceCatIds = service_cat_id.join(',');
        }
      }
      Map<String, dynamic> mapData = {"service_provider_id": serviceProviderId, "amount": amount, "date": date, "service_cat_id": serviceCatIds, "gst_amount": gst_amount, "time": time};
      if (address_lat != null && address_lat != "") {
        mapData.putIfAbsent("address_lat", () => address_lat);
      }
      if (address_long != null && address_long != "") {
        mapData.putIfAbsent("address_long", () => address_long);
      }
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      const String url = EndPoints.serviceBooking;
      final response = await netWorkLocator.dio.post(
        url,
        options: Options(headers: headers),
        data: mapData,
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
      rethrow;
    }

    return completer.future;
  }
}
