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

class BookingRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> getAllMyBookings(String currentPage) async {
    Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();
    try {
      //String dummyToken="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMjZkZjU0Mjc5ZTJkNmFlYmI0ZTlmZmYxOTgwNzMyZDc3MjhiNTlmMGI3ZTAyODliZDI0YTUxYTA4YmFmYjg1ZDY5YmY1N2IzZGZkMTY2OWYiLCJpYXQiOjE2NTU1NjkzNTcuNjg3MjA2LCJuYmYiOjE2NTU1NjkzNTcuNjg3MjEsImV4cCI6MTY4NzEwNTM1Ny42NDUxMywic3ViIjoiMSIsInNjb3BlcyI6W119.pZddoje9r6m4lBzbDCiCte_ooPAtBS4GeFCSAbRz12naGMq4HnqjFadBe6JvYtfeITSA00oom4nTyYdQBrieUkNaU8Uptm8KDOcqYEK5fbrgXkNB5cuA5mJVnMOE5qSwBV6hBTk7dsDakiIDIziRuPnqF3t5qhIRLJP3smBMP3qE_nIMPETdVYWm4fa5-ORwRnXU8MrjdxVpWzGVvoAQw_tV6Flwjut_jXFyHEdK9Fm7oIGMeXM5xzUilXV-0I5zubNk1co6nXD_mttvht1sid--AeVIGtd8uG1zvacMqmTSdXIEm-1CHitUQPrev4uBO7MC6JeAD1PA0Bx5_g4x2EuREkfc_aFtRvsNJ7SQu1khg0oKohJOM8fIabe5uwlObhhn0wZcIScvlhXbAt8yAjgou9tuknDiayIkEF1oarjIWFuctojBOfuGHN7UvZyfdNr5hCbOqOxGdNcxXrWu_id45IFVFGW6M4tY-HALcaIp73cOyzCNCnVgEEIsegEN8b_9DpLc53sShEsagVdfFcQc0GTmWG-NzYsXm3j66TashqN7se9w6G5aB5bzG-cLcUNtL_Wi8bgZc2vtNnpPS2ZXWEVMRKW3DBfwvv7x01dOMPa3JGFl6S3b5J6TcEOalaqNaFjvy0BF1p8gpzZU15Fqhr6dQjx5s0BeFuLQLgs";
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };
      final url='${EndPoints.baseUrl}${EndPoints.mybooking}?page=${currentPage}&per_page=5';
      print(url);
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

}
