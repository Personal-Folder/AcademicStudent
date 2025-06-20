import 'dart:convert';

import 'package:academic_student/core/models/instructor.dart';
import 'package:academic_student/core/models/user.dart';
import 'package:academic_student/utils/constants/services.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StaffService {
  Future<Either<List<Instructor>, String>> getInstructors() async {
    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    String getSocialGroupsUrl =
        defaultApi('instructors', Get.locale!.languageCode);
    final Uri getSocialGroupUri = Uri.parse(getSocialGroupsUrl);

    try {
      final http.Response response = await http.get(
        getSocialGroupUri,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Accept': 'application/json',
        },
      );
      final Map responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          return left(List.generate(responseArray["data"].length,
              (index) => Instructor.fromJson(responseArray["data"][index])));
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
    } catch (_) {
      rethrow;
    }
  }
}
