import 'package:academic_student/utils/constants/display_size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: websiteSize,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/error_picture.svg',
                  height: 300,
                  width: 300,
                ),
                Text(
                  kDebugMode ? errorDetails.summary.toString() : 'Oups! Something went wrong!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(color: kDebugMode ? Colors.red : Colors.black, fontWeight: FontWeight.bold, fontSize: 21),
                ),
                const SizedBox(height: 12),
                Text(
                  kDebugMode ? 'https://docs.flutter.dev/testing/errors' : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.tajawal(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
