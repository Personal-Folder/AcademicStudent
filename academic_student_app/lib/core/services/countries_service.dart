import 'dart:convert';

import 'package:academic_student/utils/constants/services.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CountriesService {
  Future<Either<List, String>> getCountries() async {
    String getCountriesUrl = defaultApi('countries', Get.locale!.languageCode);
    final Uri getCountriesUri = Uri.parse(getCountriesUrl);

    try {
      final http.Response response = await http.get(
        getCountriesUri,
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
