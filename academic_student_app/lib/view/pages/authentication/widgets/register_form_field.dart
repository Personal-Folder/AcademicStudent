import 'package:academic_student/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class RegisterFormField extends StatefulWidget {
  const RegisterFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.leading,
    required this.obsecure,
    required this.title,
    this.textDirection,
    this.textInputType = TextInputType.text,
    this.errorText,
  });

  final TextDirection? textDirection;
  final String? errorText;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final Widget? leading;
  final bool obsecure;
  final String title;

  @override
  State<RegisterFormField> createState() => _RegisterFormFieldState();
}

class _RegisterFormFieldState extends State<RegisterFormField> {
  bool isRLTFlag = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: Directionality(
            textDirection: widget.textDirection ?? (Get.locale == const Locale('ar') ? TextDirection.rtl : TextDirection.ltr),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: widget.obsecure,
              controller: widget.controller,
              keyboardType: widget.textInputType,
              textAlignVertical: TextAlignVertical.center,
              onChanged: (value) {
                setState(() {
                  error = widget.validator(value);
          
                  isRLTFlag = intl.Bidi.detectRtlDirectionality(value);
                });
              },
              decoration: InputDecoration(
                prefixIcon: widget.leading,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                constraints: const BoxConstraints(
                  minHeight: 40,
                  maxHeight: 40,
                ),
                border: error == null
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: grey,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      )
                    : const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: red,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                focusedErrorBorder: error == null
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: grey,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      )
                    : const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: red,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                enabledBorder: error == null
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: grey,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      )
                    : const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: red,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                focusedBorder: error == null
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: grey,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      )
                    : const OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: red,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                      ),
                fillColor: Colors.grey[200],
                filled: true,
                hintText: widget.title,
              ),
              textDirection: isRLTFlag ? TextDirection.rtl : TextDirection.ltr,
            ),
          ),
        ),
        if (error != null || widget.errorText != null)
          Text(
            error ?? widget.errorText ?? '',
            textAlign: TextAlign.start,
            style:  GoogleFonts.tajawal(
              color: red,
            ),
          ),
      ],
    );
  }
}
