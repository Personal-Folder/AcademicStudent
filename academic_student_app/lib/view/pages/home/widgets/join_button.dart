import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/painter/button_gradiant.dart';

class JoinButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const JoinButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        // minWidth: 40,
        maxHeight: 25,
      ),
      child: CustomPaint(
        painter: ButtonGradiantPaint(
          strokeWidth: 1,
          radius: 50,
          gradient: const LinearGradient(
            colors: [pink, aqua],
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: kIsWeb
                ? null
                : const LinearGradient(
                    colors: [aqua, pink],
                  ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: FittedBox(
              child: Text(
                title.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  fontSize: 14,
                  color: white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
