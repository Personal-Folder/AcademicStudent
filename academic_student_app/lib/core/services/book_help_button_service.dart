import 'dart:convert';

import 'package:academic_student/core/models/user.dart';
import 'package:academic_student/utils/constants/services.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookHelpButtonService {
  Future<Either<List, String>> getBookHelpButtonData() async {
    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    String getBookHelpButtonUrl = defaultApi('home/book-help-details', Get.locale!.languageCode);
    final Uri getBookHelpButtonUri = Uri.parse(getBookHelpButtonUrl);

    try {
      final http.Response response = await http.get(
        getBookHelpButtonUri,
        headers: {
          'Authorization': 'Bearer $userToken',
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
          return right(responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
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
