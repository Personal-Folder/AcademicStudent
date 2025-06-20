import 'package:academic_student/core/providers/i18n/localization_provider.dart';
import 'package:academic_student/core/providers/user_bloc/bloc/user_bloc.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/widgets/copy_right_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool firstTime = true;

  Future checkFirstTime(context) async {
    // context.read<UserBloc>().add(User)
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getBool('first_time') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkFirstTime(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.data) {
              return Scaffold(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Theme.of(context).colorScheme.primary,
                body: Center(
                  child: SizedBox(
                    width: websiteSize,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: 250,
                            height: 250,
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/academic-student/logo_white_text.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<LocalizationProvider>(context,
                                        listen: false)
                                    .firstTimeLocalization(
                                  context,
                                  const Locale('en'),
                                );
                              },
                              child: Text(
                                'english'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<LocalizationProvider>(context,
                                        listen: false)
                                    .firstTimeLocalization(
                                  context,
                                  const Locale('ar'),
                                );
                              },
                              child: Text(
                                'arabic'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CopyRightWidget(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return BlocListener<UserBloc, UserState>(
                child: Scaffold(
                  body: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 350,
                          child: Image.asset(
                            'assets/images/academic-student/logo_primary_text.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
                listener: (context, state) async {
                  if (state is UserTokenValidated) {
                    context.read<UserBloc>().add(
                          UserLogin(
                            countryCode: state.data[1]['country_code'],
                            phoneNumber: state.data[1]['phone_number'],
                            password: state.data[1]['password'],
                          ),
                        );
                  }
                  if (state is UserInitial) {
                    Navigator.of(context)
                        .pushReplacementNamed(loginScreenRoute);
                  }
                  if (state is UserLoaded) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        homeScreenRoute, ModalRoute.withName('/home'));
                  }
                },
              );
            }
          }
        });
  }
}
