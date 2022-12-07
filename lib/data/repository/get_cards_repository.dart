import 'dart:async';
import 'package:app/common/constants.dart';
import 'package:app/common/methods/custom_storage.dart';
import 'package:app/common/services/getit.dart';
import 'package:app/data/endpoints/endpoints.dart';
import 'package:app/data/network/dio_client.dart';
import 'package:app/data/network/exceptions.dart';
import 'package:dio/dio.dart';

class GetCardRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> getCards() async {
    /**/
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];
      final option = Options(headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/x-www-form-urlencoded",
      });
      var response = await netWorkLocator.dio.get(
        EndPoints.getCard,
        options: option,
      );

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
