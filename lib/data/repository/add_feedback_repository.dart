import 'dart:async';
import 'package:app/common/constants.dart';
import 'package:app/common/methods/custom_storage.dart';
import 'package:app/common/services/getit.dart';
import 'package:app/data/endpoints/endpoints.dart';
import 'package:app/data/network/dio_client.dart';
import 'package:app/data/network/exceptions.dart';
import 'package:dio/dio.dart';


class AddFeedbackRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> addFeedback({String? providerId, String? feedText, String? rating}) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
      String token = userInfo['token'];

      var data = {'service_provider': providerId, "rating": rating, "feedback_text": feedText};

      final option = Options(headers: {"Authorization": "Bearer $token", "Accept": "application/json",});
      var response = await netWorkLocator.dio.post('${EndPoints.baseUrl}${EndPoints.addFeedback}', options: option, data: data);

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
