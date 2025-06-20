// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/services.dart';
import '../models/user.dart';

class RequestService {
  Future<Either<List, String>> getRequestTypes() async {
    String getRequestTypesUrl = defaultApi('academic/requests/types', Get.locale!.languageCode);
    final Uri getRequestTypesUri = Uri.parse(getRequestTypesUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    try {
      final http.Response response = await http.get(
        getRequestTypesUri,
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

  Future<Either<List, String>> getUserRequests() async {
    String getRequestTypesUrl = defaultApi('academic/requests/for-user', Get.locale!.languageCode);
    final Uri getRequestTypesUri = Uri.parse(getRequestTypesUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    try {
      final http.Response response = await http.get(
        getRequestTypesUri,
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

  Future<List> submitRequest({
    required String title,
    required String sessionId,
    required String typeId,
    required String deliveryDate,
    required List<File> studentAttachments,
    required String studentNotes,
  }) async {
    String submitRequestUrl = defaultApi('academic/requests', Get.locale!.languageCode);
    final Uri submitRequestUri = Uri.parse(submitRequestUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    try {
      final Map<String, String> dataBody = {
        'title': title,
        'course_id': sessionId,
        'type_id': typeId,
        'delivery_date': deliveryDate,
        'student_notes': studentNotes,
      };
      final http.MultipartRequest request = http.MultipartRequest('POST', submitRequestUri);
      request.fields.addAll(dataBody);
      request.headers.addAll({
        'Authorization': 'Bearer $userToken',
        'Accept': 'Application/Json',
      });
      if (studentAttachments.isNotEmpty) {
        for (File file in studentAttachments) {
          request.files.add(
            http.MultipartFile(
              'student_attachments[]',
              File(file.path).readAsBytes().asStream(),
              File(file.path).lengthSync(),
              filename: basename(
                file.path.split("/").last,
              ),
            ),
          );
        }
      }

      // send
      http.Response response = await http.Response.fromStream(await request.send());
      Map responseArray = jsonDecode(response.body);
      if (responseArray.containsKey('success')) {
        return ['success'];
      } else {
        return ['error'];
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
