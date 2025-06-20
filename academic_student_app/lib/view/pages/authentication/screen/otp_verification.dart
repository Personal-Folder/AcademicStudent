import 'dart:async';

import 'package:academic_student/core/providers/contact_us_cubit/cubit/contact_us_cubit.dart';
import 'package:academic_student/core/services/authentication_service.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/utils/constants/text_design.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/shared/widgets/app_bar_widget.dart';
import 'package:academic_student/view/shared/widgets/copy_right_widget.dart';
import 'package:academic_student/view/shared/widgets/large_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/providers/user_bloc/bloc/user_bloc.dart';
import '../widgets/otp_field.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String countryCode;
  final String phoneNumber;
  final String email;
  const OTPVerificationScreen({super.key, required this.countryCode, required this.phoneNumber, required this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  String selectedValue = "Phone";

  // Firebase Auth initialize
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Sroll Controller
  final ScrollController scrollController = ScrollController();

  // The 4 OTP Code Controllers
  final TextEditingController firstOtp = TextEditingController();
  final TextEditingController secondOtp = TextEditingController();
  final TextEditingController thirdOtp = TextEditingController();
  final TextEditingController fourthOtp = TextEditingController();
  final TextEditingController fifthOtp = TextEditingController();
  final TextEditingController sixthOtp = TextEditingController();

  bool isLoading = false;
  // Convert Timer to String || For generating the otp Code again
  String strDigits(int n) => n.toString().padLeft(2, '0');
  Duration timerDuration = const Duration(seconds: 60);
  String fVerificationId = '';
  Future startTimer() async {
    timerDuration = const Duration(seconds: 60);
    setState(() {
      isLoading = true;
    });
    await AuthenticationService()
        .sendOTP(
      resetType: selectedValue,
      countryCode: widget.countryCode,
      phoneNumber: widget.phoneNumber,
      email: widget.email,
    )
        .then((value) {
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
    setState(() {
      isLoading = false;
    });
    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: '${widget.countryCode}${widget.phoneNumber}',
    //   verificationCompleted: (PhoneAuthCredential credential) {},
    //   verificationFailed: (FirebaseAuthException e) {
    //     print(e);
    //     CustomDialogs().errorDialog(
    //       title: e.code,
    //       message: e.message!,
    //     );
    //   },
    //   codeSent: (String verificationId, int? resendToken) {
    //     fVerificationId = verificationId;
    //   },
    //   timeout: const Duration(seconds: 60),
    //   codeAutoRetrievalTimeout: (String verificationId) async {},
    // );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // Validation Error
  Map validationErrors = {};

  @override
  Widget build(BuildContext context) {
    final timer = strDigits(timerDuration.inSeconds.remainder(60));
    return Scaffold(
      appBar: AppBarWidget(
        title: 'otp_verification'.tr,
      ),
      body: Center(
        child: SizedBox(
          width: websiteSize,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                height: 200,
                child: Image.asset(
                  'assets/images/academic-student/message_phone.png',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    setState(() {
                      isLoading = false;
                    });
                    if (state is UserValidationError) {
                      validationErrors = state.validationError;
                    }
                    if (state is UserLoaded) {
                      Navigator.of(context).pushReplacementNamed(otpSuccessRoute);
                    }
                  },
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        width: displayWidth(context),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    selectedValue == "Phone" ? 'otp_verification_number'.tr : 'otp_verification_email'.tr,
                                    style: GoogleFonts.tajawal(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    selectedValue == "Phone" ? '${widget.countryCode} ${widget.phoneNumber}' : widget.email,
                                    textDirection: TextDirection.ltr,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              if (validationErrors['otp'] != null)
                                Text(
                                  validationErrors['otp'],
                                  style: textErrorStyle,
                                ),
                              TextButton(
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
                              selectedValue == "Phone"
                                  ? TextButton(
                                      style: TextButton.styleFrom(
                                        disabledForegroundColor: grey,
                                        textStyle: textSmallButtonStyle.copyWith(
                                          decoration: TextDecoration.underline,
                                          fontSize: 18,
                                        ),
                                      ),
                                      onPressed: timer == "00"
                                          ? () {
                                              setState(() {
                                                selectedValue = "Email";
                                                startTimer();
                                              });
                                            }
                                          : null,
                                      child: Text(
                                        'try_with_email'.tr,
                                      ),
                                    )
                                  : TextButton(
                                      style: TextButton.styleFrom(
                                        disabledForegroundColor: grey,
                                        textStyle: textSmallButtonStyle.copyWith(
                                          decoration: TextDecoration.underline,
                                          fontSize: 18,
                                        ),
                                      ),
                                      onPressed: timer == "00"
                                          ? () {
                                              setState(() {
                                                selectedValue = "Phone";
                                                startTimer();
                                              });
                                            }
                                          : null,
                                      child: Text(
                                        'try_with_phone'.tr,
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              isLoading
                                  ? const CircularProgressIndicator()
                                  : LargeButton(
                                      title: 'enter'.tr,
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        validationErrors = {};
                                        final String smsCode = firstOtp.text + secondOtp.text + thirdOtp.text + fourthOtp.text + fifthOtp.text + sixthOtp.text;
                                        context.read<UserBloc>().add(OTPVerification(
                                              verificationId: fVerificationId,
                                              countryCode: widget.countryCode,
                                              phoneNumber: widget.phoneNumber,
                                              email: widget.email,
                                              otpType: selectedValue,
                                              otp: smsCode,
                                            ));
                                      },
                                      textStyle: textLargeButtonStyle,
                                    ),
                              const SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<ContactUsCubit, ContactUsState>(
                                builder: (context, state) {
                                  if (state is ContactUsLoaded) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'for_technical_support_label'.tr,
                                          style: GoogleFonts.tajawal(
                                            color: primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: state.contactUsInfos
                                              .map(
                                                (info) => IconButton(
                                                  onPressed: () async {
                                                    String url = '';
                                                    if (info.value.isEmail) {
                                                      url = 'mailto:${info.value}';
                                                    } else if (info.value.isPhoneNumber) {
                                                      url = 'tel:${info.value}';
                                                    } else {
                                                      url = info.value;
                                                    }
                                                    if (!await launchUrl(
                                                      Uri.parse(url),
                                                      mode: LaunchMode.externalApplication,
                                                    )) {
                                                      CustomDialogs().errorDialog(message: 'Couldn\'t Launch Url');
                                                    }
                                                  },
                                                  icon: SvgPicture.asset(
                                                    'assets/icons/${info.type}.svg',
                                                    colorFilter: const ColorFilter.mode(
                                                      primaryColor,
                                                      BlendMode.srcATop,
                                                    ),
                                                    height: 40,
                                                    width: 40,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ],
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (MediaQuery.of(context).viewInsets.bottom == 0) const CopyRightWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
