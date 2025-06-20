import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/utils/constants/text_design.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/shared/widgets/app_bar_widget.dart';
import 'package:academic_student/view/shared/widgets/copy_right_widget.dart';
import 'package:academic_student/view/shared/widgets/large_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPSuccessScreen extends StatelessWidget {
  const OTPSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'otp_verification',
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SizedBox(
              width: displayWidth(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/images/academic-student/success_icon.png'),
                  ),
                  Text(
                    'Code Verified Successfully',
                    style: GoogleFonts.tajawal(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  LargeButton(
                    title: 'okay'.tr,
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(loginScreenRoute);
                    },
                    textStyle: textLargeButtonStyle,
                  ),
                ],
              ),
            ),
          ),
          if (MediaQuery.of(context).viewInsets.bottom == 0) const CopyRightWidget(),
        ],
      ),
    );
  }
}
