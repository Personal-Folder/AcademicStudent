import 'dart:convert';

import 'package:academic_student/core/models/registered_course.dart';
import 'package:academic_student/core/models/user.dart';
import 'package:academic_student/core/services/fcm_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/services.dart';

class AuthenticationService {
  Future<Either<List, String>> login({
    required String countryCode,
    required String phoneNumber,
    required String password,
  }) async {
    String loginUrl = defaultApi('auth/login', Get.locale!.languageCode);
    final Uri loginUri = Uri.parse(loginUrl);

    // if (!Platform.isIOS) print({'firebase_device_token': await FirebaseMessaging.instance.getToken() ?? ''});
    final Map dataBody = {
      'country_code': countryCode,
      'phone': phoneNumber,
      'password': password,
    };
    if (await FcmService().getDeviceToken() != null) {
      dataBody['firebase_device_token'] = await FcmService().getDeviceToken();
    }

    try {
      final http.Response response = await http.post(
        loginUri,
        headers: {
          'Accept': 'Application/json',
        },
        body: dataBody,
      );
      final Map responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();

          final User user = User.fromMap(responseArray['data']['user']);
          User.token = responseArray['data']['token'];
          if (kIsWeb) {
            sharedPreferences.setString('user', user.toJson());
            sharedPreferences.setString(
                'user_token', responseArray['data']['token']);
          }
          sharedPreferences.setStringList('cridentials', [
            User.token,
            user.id.toString(),
            countryCode,
            phoneNumber,
            password,
          ]);
          return left([
            'success',
            user,
          ]); // todo: Change this when token is ready.

        case 422:
          return left(['error', responseArray['errors']]);
        case 403:
          final User user = User.fromMap(responseArray['data']['user']);
          return left([responseArray['key'], user]);
        case 404:
          return left([
            'error',
            {
              'password': [responseArray['message']]
            }
          ]);
        default:
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
      }
    } on ArgumentError catch (e) {
      throw e.message;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Either<List, String>> register({
    required String firstName,
    required String lastName,
    required String countryCode,
    required String phoneNumber,
    required int universityId,
    required int countryId,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    String registerUrl = defaultApi('auth/register', Get.locale!.languageCode);
    Uri registerUri = Uri.parse(registerUrl);

    final Map dataBody = {
      "first_name": firstName,
      "last_name": lastName,
      'university_id': universityId.toString(),
      "email": email,
      "country_code": countryCode,
      "phone": phoneNumber,
      'country_id': countryId.toString(),
      "password": password,
      "password_confirmation": confirmPassword,
    };
    if (await FcmService().getDeviceToken() != null) {
      dataBody['firebase_device_token'] = await FcmService().getDeviceToken();
    }

    try {
      final http.Response response = await http.post(
        registerUri,
        body: dataBody,
        headers: {'Accept': 'Application/json'},
      );
      final Map responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          final User user = User.fromMap(responseArray['data']['user']);
          return left(['success', user]);
        case 422:
          return left(['error', responseArray['errors']]);
        default:
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
      }
    } on ArgumentError catch (e) {
      throw e.message;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Either<List, String>> validateToken() async {
    String loginUrl =
        defaultApi('auth/validate-token', Get.locale!.languageCode);
    final Uri loginUri = Uri.parse(loginUrl);
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final List<String>? dataList =
          sharedPreferences.getStringList('cridentials');
      final http.Response response = await http.post(
        loginUri,
        headers: {
          'Accept': 'Application/json',
        },
        body: await FcmService().getDeviceToken() != null
            ? {
                'token': dataList?[0] ?? 'null',
                'user_id': dataList?[1] ?? 'null',
                'firebase_device_token': await FcmService().getDeviceToken()
              }
            : {
                'token': dataList?[0] ?? 'null',
                'user_id': dataList?[1] ?? 'null',
              },
      );
      final Map responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          if (responseArray['data']['valid']) {
            final User user = User.fromMap(responseArray['data']['user']);
            User.token = responseArray['data']['token'];
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setStringList('cridentials', [
              User.token,
              user.id.toString(),
            ]);

            return left([
              'success',
              user,
            ]);
          } else {
            return left(['error']);
          }
        case 422:
          return left(['error', responseArray['errors']]);
        case 403:
          final User user = User.fromMap(responseArray['data']['user']);
          return left([responseArray['key'], user]);
        case 404:
          return left([
            'error',
            {
              'password': [responseArray['message']]
            }
          ]);
        default:
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
      }
    } on ArgumentError catch (e) {
      throw e.message;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Either<List, String>> sendOTP({
    required String resetType,
    required String countryCode,
    required String phoneNumber,
    required String email,
  }) async {
    String verifyPhoneUrl = "";
    Map dataBody = {};
    if (resetType == "Phone") {
      verifyPhoneUrl =
          defaultApi('auth/send-otp/phone', Get.locale!.languageCode);
      dataBody = {
        'country_code': countryCode,
        'phone': phoneNumber,
      };
    } else {
      verifyPhoneUrl =
          defaultApi('auth/send-otp/email', Get.locale!.languageCode);

      dataBody = {
        'email': email,
      };
    }

    final Uri verifyPhoneUri = Uri.parse(verifyPhoneUrl);

    try {
      final http.Response response = await http.post(
        verifyPhoneUri,
        headers: {
          'Accept': 'Application/json',
        },
        body: dataBody,
      );

      final Map responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          return left(['success']);
        case 422:
          return left(['error', responseArray['errors']]);
        default:
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
      }
    } on ArgumentError catch (e) {
      throw e.message;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Either<List, String>> verifyAccount({
    required String countryCode,
    required String phoneNumber,
    required String email,
    required String otpType,
    required String otpToken,
  }) async {
    Map dataBody = {};
    String verifyAccountUrl = "";

    if (otpType == "Phone") {
      verifyAccountUrl =
          defaultApi('auth/verify/phone', Get.locale!.languageCode);

      dataBody = {
        'country_code': countryCode,
        'phone': phoneNumber,
        'otp': otpToken,
      };
    } else {
      verifyAccountUrl =
          defaultApi('auth/verify/email', Get.locale!.languageCode);

      dataBody = {
        'otp': otpToken,
        'email': email,
      };
    }
    final Uri verifyAccountUri = Uri.parse(verifyAccountUrl);

    try {
      final http.Response response = await http.post(
        verifyAccountUri,
        headers: {
          'Accept': 'Application/json',
        },
        body: dataBody,
      );

      final Map responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          final User user = User.fromMap(responseArray['data']['user']);
          return left(['success', user]);
        case 422:
          return left(['error', responseArray['errors']]);
        default:
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
      }
    } on ArgumentError catch (e) {
      throw e.message;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Either<List, String>> resetPassword({
    required String countryCode,
    required String phoneNumber,
    required String newPassword,
    required String newConfirmPassword,
    required String otpCode,
    required String email,
    required String otpType,
  }) async {
    String verifyPhoneUrl =
        defaultApi('auth/reset-password', Get.locale!.languageCode);
    final Uri verifyPhoneUri = Uri.parse(verifyPhoneUrl);
    Map dataBody = {};
    if (otpType == "Phone") {
      dataBody = {
        'country_code': countryCode,
        'phone': phoneNumber,
        'otp': otpCode,
        'password': newPassword,
        'password_confirmation': newConfirmPassword,
      };
    } else {
      dataBody = {
        'otp': otpCode,
        'email': email,
        'password': newPassword,
        'password_confirmation': newConfirmPassword,
      };
    }

    try {
      final http.Response response = await http.post(
        verifyPhoneUri,
        headers: {
          'Accept': 'Application/json',
        },
        body: dataBody,
      );

      final Map responseArray = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          return left(['success']);
        case 422:
          return left(['error', responseArray['errors']]);
        default:
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
      }
    } on ArgumentError catch (e) {
      throw e.message;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Either<List, String>> logout() async {
    String logoutUrl = defaultApi('auth/logout', Get.locale!.languageCode);
    final Uri logoutUri = Uri.parse(logoutUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    try {
      final http.Response response = await http.post(
        logoutUri,
        headers: {
          'Accept': 'Application/json',
          'Authorization': 'Bearer $userToken',
        },
      );
      final responseArray = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          return left(['success']);
        case 422:
          return left(['error']);
        default:
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
      }
    } on ArgumentError catch (e) {
      throw e.message;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Either<List, String>> selfDelete() async {
    String selfDeleteUrl =
        defaultApi('users/delete/self', Get.locale!.languageCode);
    final Uri selfDeleteUri = Uri.parse(selfDeleteUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }
    try {
      final http.Response response = await http.post(
        selfDeleteUri,
        headers: {
          'Accept': 'Application/json',
          'Authorization': 'Bearer $userToken',
        },
      );
      final responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          return left(['success']);
        case 422:
          return left(['error']);
        default:
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
      }
    } on ArgumentError catch (e) {
      throw e.message;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Either<List, String>> updateUser(
    List<dynamic> avatar,
    String firstName,
    String lastName,
    String email,
  ) async {
    String updateUserUrl = defaultApi('users/update', Get.locale!.languageCode);
    final Uri updateUserUri = Uri.parse(updateUserUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }
    try {
      dynamic responseArray;

      final request = http.MultipartRequest('POST', updateUserUri);
      request.headers.addAll(
        {
          'Accept': 'Application/json',
          'Authorization': 'Bearer $userToken',
        },
      );
      if (avatar[0] != null || avatar[1] != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'avatar',
            avatar[0],
            filename: avatar[1],
          ),
        );
      }

      request.fields['first_name'] = firstName;
      request.fields['last_name'] = lastName;
      request.fields['email'] = email;
      var response = await request.send();
      String stringResponse = await response.stream.bytesToString();

      responseArray = jsonDecode(stringResponse);
      switch (response.statusCode) {
        case 200:
          final User user = User.fromMap(responseArray['data']);

          return left([
            'success',
            user,
          ]); // todo: Change this when token is ready.

        case 422:
          return left(['error', responseArray['errors']]);
        case 403:
          final User user = User.fromMap(responseArray['data']['user']);
          return left([responseArray['key'], user]);
        case 404:
          return left([
            'error',
            {
              'password': [responseArray['message']]
            }
          ]);
        default:
          return right(
              responseArray['message'] ?? 'Unkown Error! Please Contact Us!');
      }
    } on ArgumentError catch (e) {
      throw e.message;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<Either<List<RegisteredCourse>, String>> getEnrollements() async {
    String getEnrollementsUrl =
        defaultApi('academic/enrollments', Get.locale!.languageCode);
    final Uri getEnrollementsUri = Uri.parse(getEnrollementsUrl);

    late String userToken;
    if (kIsWeb) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      userToken = sharedPreferences.getString('user_token') ?? "";
    } else {
      userToken = User.token;
    }

    try {
      final http.Response response = await http.get(
        getEnrollementsUri,
        headers: {
          'Accept': 'Application/json',
          'Authorization': 'Bearer $userToken',
        },
      );
      final responseArray = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          return left(List.generate(
              responseArray["data"].length,
              (index) =>
                  RegisteredCourse.fromJson(responseArray["data"][index])));
        case 422:
          return left([]);
        default:
          return right(responseArray['message']);
      }
    } on ArgumentError catch (e) {
      throw e.message;
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
