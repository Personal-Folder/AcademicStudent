import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class LoginFormField extends StatefulWidget {
  const LoginFormField({
    super.key,
    this.keyboardType = TextInputType.text,
    required this.controller,
    required this.validator,
    required this.obsecure,
    required this.title,
    this.textDirection,
    this.leading,
    this.errorText,
  });
  final String? errorText;

  final TextDirection? textDirection;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Widget? leading;
  final bool obsecure;
  final String title;

  @override
  State<LoginFormField> createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> with WidgetsBindingObserver {
  bool isRLTFlag = false;
  String? error;

  final FocusNode focusNode = FocusNode();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Re-initialize any required input listeners or subscriptions here
    } else if (state == AppLifecycleState.paused) {
      focusNode.unfocus();
      // Release any input listeners or subscriptions here
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
              focusNode: focusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: widget.obsecure,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              textAlignVertical: TextAlignVertical.center,
              style: GoogleFonts.tajawal(
                fontSize: 18,
              ),
              textAlign: TextAlign.start,
              onChanged: (value) {
                setState(() {
                  error = widget.validator(value);
                  isRLTFlag = intl.Bidi.detectRtlDirectionality(value);
                });
              },
              decoration: InputDecoration(
                prefixIcon: widget.leading,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                prefixIconConstraints: const BoxConstraints(
                  minHeight: 40,
                  maxHeight: 40,
                ),
                constraints: const BoxConstraints(
                  minHeight: 40,
                  maxHeight: 40,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: error == null ? grey : red,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: error == null ? grey : red,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: error == null ? grey : red,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide(
                    color: error == null ? grey : red,
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
            style: GoogleFonts.tajawal(
              color: red,
            ),
          ),
      ],
    );
  }
}
