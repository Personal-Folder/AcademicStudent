import 'package:academic_student/core/providers/country_cubit/cubit/country_cubit.dart';
import 'package:academic_student/core/providers/university_cubit/cubit/university_cubit.dart';
import 'package:academic_student/core/providers/user_bloc/bloc/user_bloc.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/country_codes.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/utils/helpers/input_validators.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/pages/authentication/widgets/register_drop_down_selector.dart';
import 'package:academic_student/view/shared/widgets/app_text_field.dart';
import 'package:academic_student/view/shared/widgets/copy_right_widget.dart';
import 'package:academic_student/view/shared/widgets/technical_support.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int countryId = -1;
  int universityId = -1;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String _countryCode = '+965';
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool loading = false;

  Map validationError = {};

  void getData() {
    context.read<CountryCubit>().getCountries();
    context.read<UniversityCubit>().getUniversities();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: MediaQuery.of(context).size.shortestSide > 600
                  ? const EdgeInsets.symmetric(horizontal: 300)
                  : const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: Image.asset(
                          'assets/images/academic-student/logo_primary_text.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      BlocConsumer<CountryCubit, CountryState>(
                        listener: (context, state) {
                          if (state is! CountryLoaded) {
                            context.read<CountryCubit>().getCountries();
                          }
                        },
                        builder: (context, state) {
                          if (state is CountryLoaded) {
                            return RegisterDropDownSelector(
                              label: "${'country_label'.tr}*",
                              items: state.countries,
                              changer: (value) {
                                countryId = value;
                              },
                            );
                          }
                          return RegisterDropDownSelector(
                            label: 'loading'.tr,
                            items: const [],
                            changer: (value) {},
                          );
                        },
                      ),
                      BlocConsumer<UniversityCubit, UniversityState>(
                        listener: (context, state) {
                          if (state is! UniversityLoaded) {
                            context.read<UniversityCubit>().getUniversities();
                          }
                        },
                        builder: (context, state) {
                          if (state is UniversityLoaded) {
                            return RegisterDropDownSelector(
                              label: "${'university_label'.tr}*",
                              items: state.universities,
                              changer: (value) {
                                universityId = value;
                              },
                            );
                          }
                          return RegisterDropDownSelector(
                            label: 'loading'.tr,
                            items: const [],
                            changer: (value) {},
                          );
                        },
                      ),
                      AppTextField(
                        isRequired: true,
                        hintText: 'first_name_label'.tr,
                        controller: _firstNameController,
                      ),
                      AppTextField(
                        isRequired: true,
                        hintText: 'last_name_label'.tr,
                        controller: _lastNameController,
                      ),
                      AppTextField(
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
                                  : const BorderSide(color: black, width: 1),
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
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ),
                          ),
                        ),
                      ),
                      AppTextField(
                        isRequired: true,
                        hintText: "email_label".tr,
                        controller: _emailController,
                      ),
                      AppTextField(
                        isRequired: true,
                        hintText: "register_password_label".tr,
                        controller: _passwordController,
                      ),
                      AppTextField(
                        isRequired: true,
                        hintText: "register_confirm_password_label".tr,
                        controller: _confirmPasswordController,
                      ),
                      BlocConsumer<UserBloc, UserState>(
                        listener: (context, state) async {
                          if (state is UnActiveUserLaoded) {
                            setState(() {
                              loading = true;
                            });
                            if (state.user.accountVerified) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('registration_complete'.tr),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                loginScreenRoute);
                                      },
                                      child: Text(
                                        'okay'.tr,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              Navigator.of(context).pushReplacementNamed(
                                  otpVerificationRoute,
                                  arguments: {
                                    'country_code': _countryCode,
                                    'phone_number': _phoneNumberController.text,
                                    'email': _emailController.text,
                                  });
                            }
                          } else if (state is UserValidationError) {
                            setState(() {
                              validationError = state.validationError;
                            });
                          }
                        },
                        builder: (context, state) {
                          if (loading || state is UserLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  foregroundColor:
                                      Theme.of(context).colorScheme.onPrimary),
                              onPressed: () async {
                                setState(() {
                                  validationError = {};
                                });
                                if (_formKey.currentState!.validate() &&
                                    InputValidator().confirmPasswordValidation(
                                            _confirmPasswordController.text,
                                            _passwordController.text,
                                            '') ==
                                        null &&
                                    InputValidator().passwordValidation(
                                            _passwordController.text, '') ==
                                        null &&
                                    InputValidator().emailVerification(
                                            _emailController.text, '') ==
                                        null &&
                                    InputValidator().phoneNumberValidation(
                                            _phoneNumberController.text, '') ==
                                        null &&
                                    InputValidator().requiredFieldValidation(
                                            _lastNameController.text) ==
                                        null &&
                                    InputValidator().requiredFieldValidation(
                                            _firstNameController.text) ==
                                        null) {
                                  context.read<UserBloc>().add(
                                        UserRegister(
                                          firstName: _firstNameController.text,
                                          lastName: _lastNameController.text,
                                          countryCode: _countryCode,
                                          phoneNumber:
                                              _phoneNumberController.text,
                                          countryId: countryId,
                                          universityId: universityId,
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          confirmPassword:
                                              _confirmPasswordController.text,
                                        ),
                                      );
                                }
                              },
                              child: Text(
                                'register_button'.tr.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              loginScreenRoute,
                              ModalRoute.withName(loginScreenRoute));
                        },
                        child: Text(
                          'login_instead'.tr,
                        ),
                      ),
                      const TechnicalSupport(),
                    ],
                  )),
            ),
            if (MediaQuery.of(context).viewInsets.bottom == 0)
              const CopyRightWidget(),
          ],
        ),
      ),
    );
  }
}
