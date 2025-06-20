import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/services.dart';
import '../models/user.dart';
import '../providers/user_bloc/bloc/user_bloc.dart';

class CourseMaterialService {
  Future<Either<List, String>> getCourseMaterial(String majorId) async {
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

    String getCoursesUrl = defaultApi(
        'academic/courses/for-university/${user.university.id}/material',
        "${Get.locale!.languageCode}&major=$majorId");
    final Uri getCoursesUri = Uri.parse(getCoursesUrl);

    try {
      final http.Response response = await http.get(
        getCoursesUri,
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

  Future<Either<List, String>> showCourseMaterial(int courseMaterialId) async {
    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    String getCoursesUrl = defaultApi(
        'academic/courses/$courseMaterialId', Get.locale!.languageCode);
    final Uri getCoursesUri = Uri.parse(getCoursesUrl);

    try {
      final http.Response response = await http.get(
        getCoursesUri,
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

  Future<Either<void, String>> toggleCourseFavorite(int courseId) async {
    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }
    String toggleCourseUrl = defaultApi(
        'academic/courses/toggle-favorite/$courseId', Get.locale!.languageCode);
    final Uri toggleCourseFavoriteUri = Uri.parse(toggleCourseUrl);
    try {
      final http.Response response = await http.post(
        toggleCourseFavoriteUri,
        body: {},
        headers: {
          'Authorization': 'Bearer $userToken',
          'Accept': 'application/json',
        },
      );
      switch (response.statusCode) {
        case 200:
          return left(null);
        case 422:
          return right("Couldn't add/remove course to/from favorites");
        case 403:
          return right("Couldn't add/remove course to/from favorites");
        default:
          return right("Couldn't add/remove course to/from favorites");
      }
    } catch (e) {
      return Right(e.toString());
    }
  }
}
