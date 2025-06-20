import 'package:academic_student/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestDetailNotes extends StatelessWidget {
  const RequestDetailNotes({
    super.key,
    required this.label,
    required this.notes,
  });

  final String label;
  final String notes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          width: double.infinity,
          child: Text(
            label.tr,
            textAlign: TextAlign.start,
            style: GoogleFonts.tajawal(
              fontSize: 18,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: grey,
            ),
          ),
          child: Text(
            notes,
          ),
        )
      ],
    );
  }
}
