import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/colors.dart';

class RequestButtonField extends StatelessWidget {
  const RequestButtonField({
    super.key,
    required this.onTap,
    required this.fieldTitle,
    required this.icon,
    this.data,
  });

  final Function onTap;
  final String fieldTitle;
  final Widget icon;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
          style: GoogleFonts.tajawal(
            color: primaryColor,
          ),
        ),
        InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              border: Border.all(
                color: grey,
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: data == null || data!.isEmpty
                ? icon
                : Text(
                    data!,
                    style: GoogleFonts.tajawal(
                      fontSize: 18,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
