import 'package:get/get.dart';

class InputValidator {
  String? requiredFieldValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'field_required'.tr;
    }
    return null;
  }

  String? phoneNumberValidation(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'field_required'.tr;
    } else if (!value.isNumericOnly) {
      return 'numeric_only'.trParams({'field': field.tr});
    }
    return null;
  }

  String? emailVerification(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'field_required'.tr;
    }
    // else if (!value.isEmail) {
    //   return 'field_email'.trParams({'field': field.tr});
    // }

    return null;
  }

  String? passwordValidation(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'field_required'.tr;
    } else if (value.length < 8) {
      return 'min_8_length'.trParams({'field': field.tr});
    }
    return null;
  }

  String? confirmPasswordValidation(String? value, String? oldValue, String field) {
    if (value == null || value.isEmpty) {
      return 'field_required'.tr;
    } else if (value.length < 8) {
      return 'min_8_length'.trParams({'field': field.tr});
    } else if (value != oldValue) {
      return 'identical_passwords'.tr;
    }
    return null;
  }
}
