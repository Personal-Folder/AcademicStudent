import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/country_codes.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/utils/helpers/input_validators.dart';
import 'package:academic_student/view/pages/authentication/screen/register.dart';
import 'package:academic_student/view/pages/authentication/screen/reset_password.dart';
import 'package:academic_student/view/pages/home/screen/home.dart';
import 'package:academic_student/view/shared/widgets/app_text_field.dart';
import 'package:academic_student/view/shared/widgets/copy_right_widget.dart';
import 'package:academic_student/view/shared/widgets/technical_support.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/providers/user_bloc/bloc/user_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form Key is used for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Text Editing Controller are for the input
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String _countryCode = '+965';

  Map validationError = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: MediaQuery.of(context).size.shortestSide > 600
            ? const EdgeInsets.symmetric(horizontal: 300)
            : const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SizedBox(
            // height:500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 400,
                          child: Image.asset(
                            'assets/images/academic-student/logo_primary_text.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          // height: 100,
                          child: AppTextField(
                            isRequired: true,
                            hintText: "phone_number_label".tr,
                            controller: _phoneNumberController,
                            isPhoneNumber: true,
                            leading: Container(
                              margin: const EdgeInsets.only(right: 8, left: 8),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: Get.locale == const Locale('ar')
                                      ? const BorderSide(color: black, width: 1)
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
                                    onSelect: (country) => setState(() {
                                      _countryCode = '+${country.phoneCode}';
                                    }),
                                  );
                                },
                                child: Text(
                                  _countryCode,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          // height: 300,
                          child: AppTextField(
                            hintText: 'password_hint'.tr,
                            isRequired: true,
                            isObscure: true,
                            maxLines: 1,
                            controller: _passwordController,
                          ),
                        ),
                        BlocConsumer<UserBloc, UserState>(
                          listener: (context, state) async {
                            if (state is UserLoaded) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen(refresh: false)));
                            }
                            if (state is UserValidationError) {
                              setState(() {
                                validationError = state.validationError;
                              });
                            }
                          },
                          builder: (context, state) {
                            if (state is UserLoading) {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const CircularProgressIndicator
                                      .adaptive(),
                                ),
                              );
                            }
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    validationError = {};
                                  });
                                  if (_formKey.currentState!.validate() &&
                                      InputValidator().phoneNumberValidation(
                                              _phoneNumberController.text,
                                              '') ==
                                          null &&
                                      InputValidator().passwordValidation(
                                              _passwordController.text, '') ==
                                          null) {
                                    context.read<UserBloc>().add(
                                          UserLogin(
                                            countryCode: _countryCode,
                                            phoneNumber:
                                                _phoneNumberController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                  }
                                },
                                child: Text('login_button'.tr),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResetPasswordScreen()));
                            },
                            child: Text('forget_password'.tr),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const TechnicalSupport(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: Text(
                            'register_instead'.tr,
                          ),
                        ),
                      ],
                    )),
                if (MediaQuery.of(context).viewInsets.bottom == 0)
                  const CopyRightWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
