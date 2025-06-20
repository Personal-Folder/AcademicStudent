import 'package:academic_student/core/providers/i18n/localization_provider.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CustomDialogs {
  void errorDialog({String? title, required String message}) {
    showDialog(
      context: navigator!.context,
      builder: (context) => AlertDialog(
        title: Text(
          title ?? 'An error has Occured',
          textAlign: TextAlign.left,
        ),
        content: Text(
          message,
          textAlign: TextAlign.justify,
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              iconColor: black,
              foregroundColor: black,
            ),
            icon: const Icon(Icons.check),
            label: Text(
              'okay'.tr,
            ),
          ),
        ],
      ),
    );
  }

  void showVerificationError(countryCode, phoneNumber, email) {
    showDialog(
      context: navigator!.context,
      builder: (context) => AlertDialog(
        title: const Text('This User is not Verified'),
        content: const Text('Please verifiy your user as soon as possible!'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                otpVerificationRoute,
                arguments: {
                  'country_code': countryCode,
                  'phone_number': phoneNumber,
                  'email': email,
                },
              );
            },
            style: TextButton.styleFrom(
              iconColor: black,
              foregroundColor: black,
            ),
            icon: const Icon(Icons.check),
            label: const Text(
              'Verify',
            ),
          ),
        ],
      ),
    );
  }

  void switchLanguage() {
    showDialog(
      context: navigator!.context,
      builder: (context) => AlertDialog(
        title: Text(
          'switch_language'.tr,
        ),
        content: SizedBox(
          width: 50,
          child: AspectRatio(
            aspectRatio: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    Provider.of<LocalizationProvider>(context, listen: false).setLocalization(
                      const Locale('ar'),
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil(homeScreenRoute, ModalRoute.withName('/home'), arguments: true);
                  },
                  style: TextButton.styleFrom(
                    fixedSize: Size(displayWidth(context), 30),
                  ),
                  child: Text(
                    'arabic'.tr,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(homeScreenRoute, ModalRoute.withName('/home'), arguments: true);
                    Provider.of<LocalizationProvider>(context, listen: false).setLocalization(
                      const Locale('en'),
                    );
                  },
                  style: TextButton.styleFrom(
                    fixedSize: Size(displayWidth(context), 30),
                  ),
                  child: Text(
                    'english'.tr,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
