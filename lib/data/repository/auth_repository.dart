import 'dart:async';
import 'dart:io';
import 'package:app/common/notification_services/notifications_services.dart';
import 'package:dio/dio.dart';
import '../../common/services/getit.dart';
import '../../common/social_auth.dart';
import '../endpoints/endpoints.dart';
import '../network/dio_client.dart';
import '../network/exceptions.dart';

class AuthRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    String? confirmPassword,
  }) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      final response = await netWorkLocator.dio.post(EndPoints.register, data: {
        'email': email,
        'password': password,
        'user_type': 2,
      });
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

  Future<Map<String, dynamic>> logIn({
    required String email,
    required String password,
  }) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      final String token = await NotificationServices.instance.getDeviceToken;
      final int deviceType = Platform.isIOS ? 1 : 2;
      final response = await netWorkLocator.dio.post(
        EndPoints.login,
        data: <String, dynamic>{
          'email': email,
          'password': password,
          'user_type': 2,
          "device_token": token,
          "device_type": deviceType,
        },
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

  Future<Map<String, dynamic>> sendOtpToEmail({
    required String email,
  }) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      final response = await netWorkLocator.dio.post(EndPoints.sendOTP, data: {
        'email': email,
      });
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

  Future<Map<String, dynamic>> resetPassword({required String email, required String otp, required String password}) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      final response = await netWorkLocator.dio.post(EndPoints.forgotPassword, data: {'otp': otp, 'password': password});
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

  Future<Map<String, dynamic>> socialSignIn(
      {required SocialAuthModel socialAuthUserCredentials,
        required String loginType}) async {
    Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();
    try {
      String deviceToken = await NotificationServices.instance.getDeviceToken;
      Map<String, dynamic> data = <String, dynamic>{
        'user_type': 3,
        "device_token": deviceToken,
        "device_type": Platform.isIOS ? 1 : 2,
        "login_type": loginType,
        "social_id": socialAuthUserCredentials.providerId,
      };

      if (socialAuthUserCredentials.email.isNotEmpty) {
        data.putIfAbsent('email', () => socialAuthUserCredentials.email);
      }
      if (socialAuthUserCredentials.displayName.isNotEmpty) {
        data.putIfAbsent('name', () => socialAuthUserCredentials.displayName);
      }
      if (socialAuthUserCredentials.photoUrl.isNotEmpty) {
        data.putIfAbsent(
            "profile_pic_url", () => socialAuthUserCredentials.photoUrl);
      }
      final response =
      await netWorkLocator.dio.post(EndPoints.socialLoginUrl, data: data);
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
