import 'dart:convert';

import 'package:academic_student/core/models/university_file.dart';
import 'package:academic_student/core/models/user.dart';
import 'package:academic_student/utils/constants/services.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UniversityFileService {
  Future<Either<List<UniversityFile>, String>> getUniversityFiles() async {
    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    String getUniversityFilesUrl =
        defaultApi('home/university-attachments', Get.locale!.languageCode);
    final Uri getUniversityFilesUri = Uri.parse(getUniversityFilesUrl);

    try {
      final http.Response response = await http.get(
        getUniversityFilesUri,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Accept': 'application/json',
        },
      );
      final Map responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          return left(List.generate(
              responseArray["data"].length,
              (index) =>
                  UniversityFile.fromJson(responseArray["data"][index])));
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
