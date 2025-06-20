import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/services.dart';
import '../models/user.dart';

class SettingService {
  Future<Either<List, String>> getAboutUs() async {
    String getAboutUsInfoUrl = defaultApi('settings/about-us', Get.locale!.languageCode);
    final Uri getAboutUsInfoUri = Uri.parse(getAboutUsInfoUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    try {
      final http.Response response = await http.get(
        getAboutUsInfoUri,
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

  Future<Either<List, String>> getLegalAgreements(String key) async {
    String getTermsConditionsUrl = defaultApi('settings/legal_agreements.$key', Get.locale!.languageCode);
    final Uri getTermsConditionsUri = Uri.parse(getTermsConditionsUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    try {
      final http.Response response = await http.get(
        getTermsConditionsUri,
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
