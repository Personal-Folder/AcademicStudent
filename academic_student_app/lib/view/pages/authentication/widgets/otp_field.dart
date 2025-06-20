import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/colors.dart';

class OTPField extends StatelessWidget {
  final TextEditingController controller;
  const OTPField({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: lightBlue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Align(
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
              cursorHeight: 40,
              maxLength: 1,
              style: GoogleFonts.tajawal(fontSize: 35),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                counterText: '',
                isCollapsed: true,
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  FocusScope.of(context).nextFocus();
                }
                if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
