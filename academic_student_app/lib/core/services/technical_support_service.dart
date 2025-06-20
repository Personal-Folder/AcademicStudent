import 'dart:convert';

import 'package:academic_student/core/models/user.dart';
import 'package:academic_student/utils/constants/services.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TechnicalSupportService {
  Future sendTechnicalSupportMessage({required String subject, required String body}) async {
    final String sendTechincalSupportMessageUrl = defaultApi('messages', Get.locale!.countryCode);
    final Uri sendTechnicalSupportMessageUri = Uri.parse(sendTechincalSupportMessageUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    try {
      http.Response response = await http.post(
        sendTechnicalSupportMessageUri,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Accept': 'Application/Json',
        },
        body: {
          'subject': subject,
          'body': body,
        },
      );
      final Map responseArray = jsonDecode(response.body);
      if (responseArray.containsKey('success')) {
        return ['success'];
      } else {
        return ['error'];
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
  }

  Future<Either<List, String>> getTechnicalSupportDetails() async {
    final String sendTechincalSupportMessageUrl = defaultApi('messages/contact-details', Get.locale!.countryCode);
    final Uri sendTechnicalSupportMessageUri = Uri.parse(sendTechincalSupportMessageUrl);

    try {
      http.Response response = await http.get(
        sendTechnicalSupportMessageUri,
        headers: {
          // 'Authorization': 'Bearer ${User.token}',
          'Accept': 'Application/Json',
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
          return right(responseArray['message']);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
