import 'dart:convert';

import 'package:academic_student/core/models/section.dart';
import 'package:academic_student/core/providers/user_bloc/bloc/user_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/services.dart';
import '../models/user.dart';

class SectionService {
  Future<Either<List<Section>, String>> getSections() async {
    late User user;
    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      user = User.fromJson(sharedPreferences.getString('user') ?? "");
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      final userState =
          BlocProvider.of<UserBloc>(navigator!.context).state as UserLoaded;
      user = userState.user;
      userToken = User.token;
    }

    String getSectionUrl = defaultApi(
        'sections/for-university/${user.university.id}',
        Get.locale!.languageCode);
    final Uri getSectionUri = Uri.parse(getSectionUrl);

    try {
      final http.Response response = await http.get(
        getSectionUri,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Accept': 'application/json',
        },
      );

      final Map responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          return left(List.generate(responseArray["data"].length,
              (index) => Section.fromJson(responseArray["data"][index])));
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

  Future<Either<List, String>> showSectionData(int sectionId) async {
    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    String getSectionUrl =
        defaultApi('academic/sections/$sectionId', Get.locale!.languageCode);
    final Uri getSectionUri = Uri.parse(getSectionUrl);

    try {
      final http.Response response = await http.get(
        getSectionUri,
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
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<void, String>> toggleSectionFavorite(int sectionId) async {
    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    String toggleSectionUrl = defaultApi(
        'academic/sections/toggle-favorite/$sectionId',
        Get.locale!.languageCode);
    final Uri toggleSectionFavoriteUri = Uri.parse(toggleSectionUrl);

    try {
      final http.Response response = await http.post(
        toggleSectionFavoriteUri,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Accept': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          return left(null);
        case 422:
          return right("Couldn't add/remove section to/from favorites");
        case 403:
          return right("Couldn't add/remove section to/from favorites");
        default:
          return right("Couldn't add/remove section to/from favorites");
      }
    } catch (e) {
      rethrow;
    }
  }
}
