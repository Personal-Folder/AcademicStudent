import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';

class TechnicaSupportField extends StatelessWidget {
  const TechnicaSupportField({
    super.key,
    required this.controller,
    required this.validator,
    required this.title,
    this.maxLines,
    this.errorText,
    this.maxLength,
  });
  final String? errorText;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final String title;
  final int? maxLines;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: (value) => validator(value),
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.center,
      maxLines: maxLines,
      maxLength: maxLength,
      enableSuggestions: false,
      autocorrect: false,
      textInputAction: TextInputAction.newline,
      decoration: InputDecoration(
        contentPadding: Get.locale == const Locale('ar')
            ? const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              )
            : const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
        errorText: errorText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: grey,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: red,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: red,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: grey,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            color: primaryColor,
            style: BorderStyle.solid,
            width: 2,
          ),
        ),
        fillColor: Colors.transparent,
        isCollapsed: true,
        filled: false,
        hintText: title.tr,
      ),
      textDirection: TextDirection.ltr,
    );
  }
}
