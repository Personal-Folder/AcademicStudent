import 'package:academic_student/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeComponentHeader extends StatelessWidget {
  const HomeComponentHeader(
      {super.key, required this.title, this.showAllBtn = true});
  final String title;
  final bool? showAllBtn;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.tr,
            style:
                GoogleFonts.tajawal(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          if (showAllBtn!)
            Text(
              "See all",
              style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.bold, color: primaryColor),
            ),
          if (!showAllBtn!) const SizedBox()
        ],
      ),
    );
  }
}
