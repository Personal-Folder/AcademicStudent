import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/services.dart';
import '../models/user.dart';
import '../providers/user_bloc/bloc/user_bloc.dart';

class MajorService {
  Future<Either<List, String>> getMajors(String sectionId) async {
    late User user;
    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      user = User.fromJson(sharedPreferences.getString('user') ?? "");
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      final userState = BlocProvider.of<UserBloc>(navigator!.context).state as UserLoaded;
      user = userState.user;
      userToken = User.token;
    }

    String getMajorsUrl = defaultApi('majors/for-university-section/${user.university.id}/$sectionId', Get.locale!.languageCode);
    final Uri getMajorsUri = Uri.parse(getMajorsUrl);

    try {
      final http.Response response = await http.get(
        getMajorsUri,
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

  Future<Either<List, String>> showMajor(int majorId) async {
    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    String geMajorUrl = defaultApi('academic/majors/$majorId', Get.locale!.languageCode);
    final Uri getMajorUri = Uri.parse(geMajorUrl);

    try {
      final http.Response response = await http.get(
        getMajorUri,
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
    } catch (e) {
      rethrow;
    }
  }
}
