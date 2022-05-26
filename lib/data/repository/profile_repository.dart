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
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ProfileRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> createProfile({
    required String fName,
    required String lName,
    required int gender,
    required String address,
    required String mobile,
    required String imagePath,
  }) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
    String token = userInfo['token'];
    final mimeTypeData = lookupMimeType(imagePath, headerBytes: [0xFF, 0xD8])?.split('/');
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data; boundary=<calculated when request is sent>"
      };
      FormData formData = FormData.fromMap({
        'first_name': fName,
        'last_name': lName,
        'gender': "1",
        'address': address,
        'mobile': mobile,
        'user_image': MultipartFile.fromFileSync(imagePath,
            contentType: MediaType(mimeTypeData![0], mimeTypeData[1]), filename: basename(imagePath)),
      });
      netWorkLocator.dio.options.connectTimeout = 500000;
      netWorkLocator.dio.options.receiveTimeout = 1000000;
      /*netWorkLocator.dio.options.followRedirects = false;*/
      /*netWorkLocator.dio.options.validateStatus = (status) {
        return status! < 500;
      };*/
      final response = await netWorkLocator.dio.post('${EndPoints.baseUrl}${EndPoints.profile}',
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

  Future<User?> getUserProfileDetails() async {
    var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
    String token = userInfo['token'];
    try {
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      final response = await netWorkLocator.dio.get(
        '${EndPoints.baseUrl}${EndPoints.getProfile}',
        options: Options(
          headers: headers,
        ),
      );
      return User.fromJson(response.data);
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
