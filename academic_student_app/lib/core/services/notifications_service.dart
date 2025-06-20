import 'dart:convert';

import 'package:academic_student/core/models/notification.dart';
import 'package:academic_student/core/models/user.dart';
import 'package:academic_student/utils/constants/services.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsService {
  Future<Either<List<AppNotification>, String>> getNotifications() async {
    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    String getNotifications =
        defaultApi('notifications', Get.locale!.languageCode);
    final Uri getNotificationsUri = Uri.parse(getNotifications);

    try {
      final http.Response response = await http.get(
        getNotificationsUri,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Accept': 'Application/Json',
        },
      );

      final Map responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          return left(List.generate(
              (responseArray['data'] ?? []).length,
              (index) => AppNotification.fromJson(
                  (responseArray['data'] ?? [])[index])));
        case 422:
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
        case 403:
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
        default:
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
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
