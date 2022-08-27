import 'dart:async';
import 'dart:convert';

import 'package:app/common/constants.dart';
import 'package:app/common/methods/custom_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../common/services/getit.dart';
import '../endpoints/endpoints.dart';
import '../network/dio_client.dart';
import '../network/exceptions.dart';

class HomeRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> getBanners() async {
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
        '${EndPoints.baseUrl}${EndPoints.banner}',
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
