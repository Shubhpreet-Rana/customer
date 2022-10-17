import 'dart:async';
import 'dart:convert';

import 'package:app/common/constants.dart';
import 'package:app/common/methods/custom_storage.dart';
import 'package:app/common/services/getit.dart';
import 'package:app/data/endpoints/endpoints.dart';
import 'package:app/data/network/dio_client.dart';
import 'package:app/data/network/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class GetCardRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> getCards() async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String,dynamic>>();
    try {
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token ="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMjZkZjU0Mjc5ZTJkNmFlYmI0ZTlmZmYxOTgwNzMyZDc3MjhiNTlmMGI3ZTAyODliZDI0YTUxYTA4YmFmYjg1ZDY5YmY1N2IzZGZkMTY2OWYiLCJpYXQiOjE2NTU1NjkzNTcuNjg3MjA2LCJuYmYiOjE2NTU1NjkzNTcuNjg3MjEsImV4cCI6MTY4NzEwNTM1Ny42NDUxMywic3ViIjoiMSIsInNjb3BlcyI6W119.pZddoje9r6m4lBzbDCiCte_ooPAtBS4GeFCSAbRz12naGMq4HnqjFadBe6JvYtfeITSA00oom4nTyYdQBrieUkNaU8Uptm8KDOcqYEK5fbrgXkNB5cuA5mJVnMOE5qSwBV6hBTk7dsDakiIDIziRuPnqF3t5qhIRLJP3smBMP3qE_nIMPETdVYWm4fa5-ORwRnXU8MrjdxVpWzGVvoAQw_tV6Flwjut_jXFyHEdK9Fm7oIGMeXM5xzUilXV-0I5zubNk1co6nXD_mttvht1sid--AeVIGtd8uG1zvacMqmTSdXIEm-1CHitUQPrev4uBO7MC6JeAD1PA0Bx5_g4x2EuREkfc_aFtRvsNJ7SQu1khg0oKohJOM8fIabe5uwlObhhn0wZcIScvlhXbAt8yAjgou9tuknDiayIkEF1oarjIWFuctojBOfuGHN7UvZyfdNr5hCbOqOxGdNcxXrWu_id45IFVFGW6M4tY-HALcaIp73cOyzCNCnVgEEIsegEN8b_9DpLc53sShEsagVdfFcQc0GTmWG-NzYsXm3j66TashqN7se9w6G5aB5bzG-cLcUNtL_Wi8bgZc2vtNnpPS2ZXWEVMRKW3DBfwvv7x01dOMPa3JGFl6S3b5J6TcEOalaqNaFjvy0BF1p8gpzZU15Fqhr6dQjx5s0BeFuLQLgs" /*userInfo['token']*/;
      final option = Options(headers: {"Authorization": "Bearer $token", "Content-Type": "application/x-www-form-urlencoded"});
      var response = await netWorkLocator.dio.get('${EndPoints.baseUrl}${EndPoints.getCard}', options: option);

      if (response.statusCode == 200) {
        completer.complete(response.data);
      }
    } catch (e) {
      dynamic error = {"message": "failed", "status": 0};
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
