import 'dart:async';
import 'dart:convert';

import 'package:app/common/services/getit.dart';
import 'package:app/data/network/dio_client.dart';
import 'package:app/data/network/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class PaymentRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<dynamic> makePayment({String? currency, String? amount}) async {
    Completer<dynamic> completer = Completer<dynamic>();
    try {
      var data = {"amount": calculateAmount(amount!), "currency": currency, "payment_method_types[]": "card"};

      final option = Options(headers: {
        "Authorization": "Bearer sk_test_51L8Ss2Ih6nYkk6h8uk7Hnlr2JIY0spD23hAClpAJAWEn2MgF1zZVn2ckxNbzyOtwjWuu2i5tT9W9mVaqEbSzYcRI00I9RmIXvh",
        "Content-Type": "application/x-www-form-urlencoded"
      });
      var response = await netWorkLocator.dio.postUri(Uri.parse("https://api.stripe.com/v1/payment_intents"), data: data, options: option);
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

  calculateAmount(String amount) {
    final price = int.parse(amount)*100;
    return price.toString();
  }

  Future<dynamic> onGooglePayResult(paymentResult) async {
    Completer<dynamic> completer = Completer<dynamic>();
    try {
      final response = await makePayment();
      final clientSecret = response['clientSecret'];
      final token = paymentResult['paymentMethodData']['tokenizationData']['token'];
      final tokenJson = Map.castFrom(json.decode(token));
      if (tokenJson.isNotEmpty) {
        return completer.complete(tokenJson);
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
    return completer;
  }
}
