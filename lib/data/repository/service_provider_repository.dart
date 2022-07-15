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
    Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();
    try {
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      final response = await netWorkLocator.dio.get(
        '${EndPoints.baseUrl}${EndPoints.getCategoryList}',
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

  Future<Map<String, dynamic>> getAllServiceProvider(
      {String? categoryName, String? catid,String? rating}) async {
    Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();
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
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      String url = "${EndPoints.baseUrl}${EndPoints.getProviderList}";
      print(url);
      final response = await netWorkLocator.dio.get(url,
          options: Options(
            headers: headers,
          ),
          queryParameters: mapData);
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
