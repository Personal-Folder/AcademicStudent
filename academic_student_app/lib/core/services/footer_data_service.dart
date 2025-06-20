import 'dart:convert';

import 'package:academic_student/core/models/user.dart';
import 'package:academic_student/utils/constants/services.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:http/http.dart' as http;

class FooterDataService {
  Future<Either<List, String>> getFooterData() async {
    final String sendTechincalSupportMessageUrl = defaultApi('home/footer', Get.locale!.countryCode);
    final Uri sendTechnicalSupportMessageUri = Uri.parse(sendTechincalSupportMessageUrl);

    try {
      http.Response response = await http.get(
        sendTechnicalSupportMessageUri,
        headers: {
          'Authorization': 'Bearer ${User.token}',
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
