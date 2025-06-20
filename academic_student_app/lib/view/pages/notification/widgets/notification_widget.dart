import 'package:academic_student/core/models/major.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/colors.dart';

class NotificationWidget extends StatelessWidget {
  final Major major;
  const NotificationWidget({
    super.key,
    required this.major,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        15,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [aqua, pink],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.center,
      child: AutoSizeText(
        major.title,
        maxLines: 2,
        wrapWords: false,
        textAlign: TextAlign.center,
        style: GoogleFonts.tajawal(
          fontSize: 32,
          color: white,
        ),
      ),
    );
  }
}
