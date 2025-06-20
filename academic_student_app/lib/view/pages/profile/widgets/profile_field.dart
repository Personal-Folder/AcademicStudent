import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/colors.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileField({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: AutoSizeText(
            label.tr,
            maxLines: 1,
            style: GoogleFonts.tajawal(
              fontSize: 20,
              color: primaryColor,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 30,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: grey,
                width: 1,
              ),
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              style: GoogleFonts.tajawal(
                color: grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ],
    );
  }
}
