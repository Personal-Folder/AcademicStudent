import 'package:academic_student/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider with ChangeNotifier {
  Locale locale = const Locale('en', 'US');
  LocalizationProvider(this.locale);

  void setLocalization(Locale locale) async {
    this.locale = locale;
    // Shared Preferences data
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('locale_code', this.locale.languageCode);
    sharedPreferences.setBool('first_time', false);
    // Go to login screen
    Get.updateLocale(this.locale);

    notifyListeners();
  }

  void firstTimeLocalization(BuildContext context, Locale locale) async {
    setLocalization(locale);

    // Navigate to Login Screen
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(loginScreenRoute);
  }

  Locale get getLocalization => locale;
}
