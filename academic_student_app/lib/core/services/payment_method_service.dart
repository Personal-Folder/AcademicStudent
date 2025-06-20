import 'dart:convert';

import 'package:academic_student/core/models/user.dart';
import 'package:academic_student/utils/constants/services.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaymentService {
  Future<Either<List, String>> getPaymentMethods() async {
    String getPaymentMethodsUrl = defaultApi('payments/methods', Get.locale!.languageCode);
    final Uri getPaymentMethodsUri = Uri.parse(getPaymentMethodsUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    try {
      final http.Response response = await http.get(
        getPaymentMethodsUri,
        headers: {
          'Authorization': 'Bearer $userToken',
        },
      );

      final Map responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          return left(['success', responseArray['data']]);
        case 422:
          return left(['error', responseArray['errors']]);
        case 403:
          return left([responseArray['key']]);
        default:
          return right(responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<List, String>> getReDirectUrl(
    int sessionId,
    int subscribtionTypeId,
    String methodKey,
  ) async {
    String getPaymentMethodsUrl = defaultApi('payments/methods/redirect-link/$sessionId/$subscribtionTypeId/$methodKey', Get.locale!.languageCode);
    final Uri getPaymentMethodsUri = Uri.parse(getPaymentMethodsUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    try {
      final http.Response response = await http.get(
        getPaymentMethodsUri,
        headers: {
          'Authorization': 'Bearer $userToken',
        },
      );

      final Map responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          return left(['success', responseArray['data']]);
        case 422:
          return left(['error', responseArray['errors']]);
        case 403:
          return left([responseArray['key']]);
        default:
          return right(responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
      }
    } catch (e) {
      rethrow;
    }
  }
}
