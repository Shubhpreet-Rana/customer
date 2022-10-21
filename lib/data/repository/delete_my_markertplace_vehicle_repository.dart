import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../../common/constants.dart';
import '../../common/methods/custom_storage.dart';
import '../../common/services/getit.dart';
import '../../model/user.dart';
import '../endpoints/endpoints.dart';
import '../network/dio_client.dart';
import '../network/exceptions.dart';


class DeleteMyMarketPlaceVehicleRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> deleteMyMarketPlaceVehicle({
    required String id
  }) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
    String token = userInfo['token'];

    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await netWorkLocator.dio.delete('${EndPoints.baseUrl}${EndPoints.deleteMyMarketPlaceVehicle}?id=$id',
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

}
