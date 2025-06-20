import 'dart:convert';

import 'package:academic_student/core/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants/services.dart';
import '../providers/user_bloc/bloc/user_bloc.dart';

class SessionMaterialsService {
  Future<Either<List, String>> getSessionMaterial(String courseMaterialId) async {
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

    String getCoursesUrl = defaultApi('academic/sessions/for-university/${user.university.id}/material', '${Get.locale!.languageCode}&course=$courseMaterialId');
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

  Future<Either<List, String>> showSessionMaterial(int sessionId) async {
    String getCoursesUrl = defaultApi('academic/sessions/$sessionId', Get.locale!.languageCode);
    final Uri getCoursesUri = Uri.parse(getCoursesUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    try {
      final http.Response response = await http.get(
        getCoursesUri,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Accept': 'Application/Json',
          'Platform': kIsWeb ? 'web' : 'mobile',
          'App-Version': (await PackageInfo.fromPlatform()).version,
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
