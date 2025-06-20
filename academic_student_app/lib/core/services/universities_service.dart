import 'dart:convert';

import 'package:academic_student/utils/constants/services.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UniversitiesService {
  Future<Either<List, String>> getCountries() async {
    String getUniversitiesUrl = defaultApi('universities', Get.locale!.languageCode);
    final Uri getUniversitiesUri = Uri.parse(getUniversitiesUrl);

    try {
      final http.Response response = await http.get(
        getUniversitiesUri,
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
