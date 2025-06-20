import 'dart:convert';

import 'package:academic_student/core/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:academic_student/utils/constants/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstructorService {
  Future<Either<List, String>> getInstructors() async {
    String getInstructorsUrl = defaultApi('home/instructors', Get.locale!.languageCode);
    final Uri getInstructorUri = Uri.parse(getInstructorsUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    try {
      final http.Response response = await http.get(
        getInstructorUri,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Accept': 'application/json',
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
    } catch (exception) {
      rethrow;
    }
  }
}
