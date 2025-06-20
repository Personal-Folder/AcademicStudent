import 'dart:async';

import 'package:academic_student/core/providers/contact_us_cubit/cubit/contact_us_cubit.dart';
import 'package:academic_student/core/services/authentication_service.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/country_codes.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/utils/constants/text_design.dart';
import 'package:academic_student/utils/extensions/column_ext.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:academic_student/utils/helpers/input_validators.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/pages/authentication/widgets/otp_field.dart';
import 'package:academic_student/view/pages/authentication/widgets/reset_password_field.dart';
import 'package:academic_student/view/shared/widgets/app_text_field.dart';
import 'package:academic_student/view/shared/widgets/copy_right_widget.dart';
import 'package:academic_student/view/shared/widgets/large_button.dart';
import 'package:academic_student/view/shared/widgets/technical_support.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String selectedValue = "Phone";

  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController email = TextEditingController();

  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmNewPassword = TextEditingController();

  Map validationError = {};

  String countryCode = '+965';

  // The 6 OTP Code Controllers
  final TextEditingController firstOtp = TextEditingController();
  final TextEditingController secondOtp = TextEditingController();
  final TextEditingController thirdOtp = TextEditingController();
  final TextEditingController fourthOtp = TextEditingController();
  final TextEditingController fifthOtp = TextEditingController();
  final TextEditingController sixthOtp = TextEditingController();

  String otpError = "";

  String verificationId = "";

  bool codeIsSent = false;

  bool isLoading = false;

  Duration timerDuration = const Duration(seconds: 60);
  Future startTimer() async {
    timerDuration = const Duration(seconds: 60);
    await AuthenticationService()
        .sendOTP(
      resetType: selectedValue,
      countryCode: countryCode,
      phoneNumber: phoneNumber.text,
      email: email.text,
    )
        .then((value) {
      setState(() {
        codeIsSent = true;
      });

      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timerDuration.inSeconds > 0) {
          if (mounted) {
            setState(() {
              timerDuration = Duration(seconds: timerDuration.inSeconds - 1);
            });
          }
        } else {
          timer.cancel();
        }
      });
      value.fold((listResult) {
        if (listResult[0] == 'success') {}
      }, (stringResult) {
        CustomDialogs().errorDialog(message: stringResult);
      });
    });
  }

  String strDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final timer = strDigits(timerDuration.inSeconds.remainder(60));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'reset_password'.tr,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: websiteSize,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RadioMenuButton(
                            value: 'Phone',
                            groupValue: selectedValue,
                            onChanged: (selected) {
                              setState(() {
                                selectedValue = selected ?? selectedValue;
                                codeIsSent = false;
                                isLoading = false;
                              });
                            },
                            child: const Text('Phone'),
                          ),
                          RadioMenuButton(
                            value: 'Email',
                            groupValue: selectedValue,
                            onChanged: (selected) {
                              setState(() {
                                selectedValue = selected ?? selectedValue;
                                codeIsSent = false;
                                isLoading = false;
                              });
                            },
                            child: const Text('Email'),
                          ),
                        ],
                      ),
                      selectedValue == "Phone"
                          ? AppTextField(
                              hintText: "phone_number_hint".tr,
                              leading: Container(
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: Get.locale == const Locale('ar')
                                        ? const BorderSide(
                                            color: black, width: 1)
                                        : BorderSide.none,
                                    right: Get.locale == const Locale('ar')
                                        ? BorderSide.none
                                        : const BorderSide(
                                            color: black, width: 1),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    showCountryPicker(
                                      context: context,
                                      showPhoneCode: true,
                                      showWorldWide: false,
                                      countryFilter: arabicCountries,
                                      countryListTheme: CountryListThemeData(
                                        bottomSheetHeight:
                                            displayHeight(context) * 0.7,
                                        borderRadius: BorderRadius.circular(0),
                                        backgroundColor: Colors.white,
                                      ),
                                      onSelect: (country) {
                                        setState(() {
                                          countryCode = "+${country.phoneCode}";
                                        });
                                      },
                                    );
                                  },
                                  child: Text(
                                    countryCode,
                                    style:
                                        GoogleFonts.tajawal(color: Colors.grey),
                                  ),
                                ),
                              ),
                              controller: phoneNumber,
                            )
                          : AppTextField(
                              controller: email,
                              hintText: 'email_hint'.tr,
                            ),
                      codeIsSent
                          ? Column(
                              children: [
                                SizedBox(
                                  // height: 100,
                                  width: double.infinity,
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        OTPField(
                                          controller: firstOtp,
                                        ),
                                        OTPField(
                                          controller: secondOtp,
                                        ),
                                        OTPField(
                                          controller: thirdOtp,
                                        ),
                                        OTPField(
                                          controller: fourthOtp,
                                        ),
                                        OTPField(
                                          controller: fifthOtp,
                                        ),
                                        OTPField(
                                          controller: sixthOtp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (validationError.containsKey('otp'))
                                  Text(
                                    validationError['otp'][0],
                                    style: textErrorStyle,
                                  ),
                                if (otpError.isNotEmpty)
                                  Text(
                                    otpError,
                                    style: textErrorStyle,
                                  ),
                                AppTextField(
                                  controller: newPassword,
                                  hintText: 'new_password_hint'.tr,
                                ),
                                AppTextField(
                                  controller: confirmNewPassword,
                                  hintText: 'new_confirm_password_hint'.tr,
                                ),
                                if (validationError.containsKey('password'))
                                  Text(
                                    validationError['password'][0],
                                    style: textErrorStyle,
                                  ),
                                isLoading
                                    ? const CircularProgressIndicator()
                                    : ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          // final FirebaseAuth auth = FirebaseAuth.instance;
                                          final String smsCode = firstOtp.text +
                                              secondOtp.text +
                                              thirdOtp.text +
                                              fourthOtp.text +
                                              fifthOtp.text +
                                              sixthOtp.text;
                                          // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

                                          try {
                                            // await auth.signInWithCredential(credential).then((value) async {
                                            //   if (await value.user?.getIdToken() != null) {
                                            await AuthenticationService()
                                                .resetPassword(
                                              countryCode: countryCode,
                                              phoneNumber: phoneNumber.text,
                                              newPassword: newPassword.text,
                                              newConfirmPassword:
                                                  confirmNewPassword.text,
                                              otpCode: smsCode,
                                              otpType: selectedValue,
                                              email: email.text,
                                            )
                                                .then((result) {
                                              result.fold(
                                                (listResult) {
                                                  if (listResult[0] ==
                                                      "success") {
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            loginScreenRoute);
                                                  } else if (listResult[0] ==
                                                      "error") {
                                                    validationError =
                                                        listResult[1];
                                                  } else {
                                                    CustomDialogs().errorDialog(
                                                        message:
                                                            'Error Has Ocured. Please Contact Us, if that happend again!');
                                                  }
                                                },
                                                (stringResult) {
                                                  CustomDialogs().errorDialog(
                                                      message: stringResult);
                                                },
                                              );
                                            });
                                            //   }
                                            // });
                                          } on FirebaseAuthException catch (_) {
                                            setState(() {
                                              otpError = 'not_valid'.tr;
                                            });
                                          } catch (e) {
                                            CustomDialogs().errorDialog(
                                                message: e.toString());
                                          }
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                        child: Text('verify_code'.tr),
                                      ),
                              ],
                            ).applyPadding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                            )
                          : isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await startTimer();
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  child: Text('send_code'.tr),
                                ),
                      !codeIsSent
                          ? const SizedBox.shrink()
                          : TextButton(
                              style: TextButton.styleFrom(
                                disabledForegroundColor: grey,
                                textStyle: textSmallButtonStyle.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: timer == '00'
                                  ? () {
                                      startTimer();
                                    }
                                  : null,
                              child: Text(
                                're_send_otp_code'.trParams({
                                  'time': timer == '00' ? '' : timer,
                                }),
                              ),
                            ),
                    ],
                  ).applyPadding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15,
                    ),
                  ),
                ),
              ),
              if (MediaQuery.of(context).viewInsets.bottom == 0)
                const TechnicalSupport(),
            ],
          ),
        ),
      ),
    );
  }
}
