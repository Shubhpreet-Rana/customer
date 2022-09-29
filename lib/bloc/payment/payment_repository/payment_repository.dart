import 'dart:async';
import 'dart:convert';

import 'package:app/common/services/getit.dart';
import 'package:app/data/network/dio_client.dart';
import 'package:app/data/network/exceptions.dart';
import 'package:dio/dio.dart';

class PaymentRepository {
  final netWorkLocator = getIt.get<DioClient>();

  Future<Map<String, dynamic>> makePayment({
  String? currency,
    String?amount
}) async {
    Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
    try {
      var data={
       "amount":calculateAmount(amount!),
       "currency":currency,
        "payment_method_types[]":"card"
      };

      final option=Options(
        headers: {"Authorization":"Bearer sk_test_Sf8jl1Zgg7mayOVbohZkJx1c00A93cYPkl",
        "Content-Type":"application/x-www-form-urlencoded"}
      );
      var response= await netWorkLocator.dio.post("https://api.stripe.com/v1/payment_intents",
      data:data,
      options: option);

      completer.complete(jsonDecode(response.data));
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

  calculateAmount(String amount) {
    final price=int.parse(amount)*100;
    return price;
  }


}