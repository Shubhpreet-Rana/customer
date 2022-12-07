import 'dart:async';
import 'package:dio/dio.dart';
import '../../common/constants.dart';
import '../../common/methods/custom_storage.dart';
import '../../common/services/getit.dart';
import '../endpoints/endpoints.dart';
import '../network/dio_client.dart';
import '../network/exceptions.dart';

class MarkAsCompleteRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> markAsComplete({required String amount, required String description, required int bookingId, required int status}) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    var userInfo = PreferenceUtils.getUserInfo(AppConstants.userInfo);
    String token = userInfo['token'];
    try {
      Options options = Options(
        headers: <String, dynamic>{
          Headers.contentTypeHeader: "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      final response = await netWorkLocator.dio.post(
        EndPoints.markAsComplete,
        data: <String, dynamic>{
          'booking_id': bookingId,
          "booking_status": status,
        },
        options: options,
      );
      if (response.statusCode != 200) {
        throw Exception('Failed');
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
