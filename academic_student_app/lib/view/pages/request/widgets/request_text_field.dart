import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/colors.dart';

class RequestTextField extends StatelessWidget {
  const RequestTextField({
    super.key,
    required this.fieldTItle,
    required this.controller,
    required this.linesRange,
  });

  final String fieldTItle;
  final TextEditingController controller;
  final RangeValues linesRange;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTItle,
          style:  GoogleFonts.tajawal(
            color: primaryColor,
          ),
        ),
        TextField(
          controller: controller,
          style: GoogleFonts.tajawal(fontSize: 16),
          cursorHeight: 20,
          minLines: linesRange.start.toInt(),
          maxLines: linesRange.end.toInt(),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            border: OutlineInputBorder(
              gapPadding: 0.1,
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
      ],
    );
  }
}
