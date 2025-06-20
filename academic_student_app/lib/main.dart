// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:ui';

import 'package:academic_student/core/providers/book_help_button_cubit/cubit/book_help_button_cubit.dart';
import 'package:academic_student/core/providers/bottom_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'package:academic_student/core/providers/footer_cubit/cubit/footer_cubit.dart';
import 'package:academic_student/core/providers/registered_course_bloc/registered_course_details_bloc.dart';
import 'package:academic_student/core/providers/registered_courses_bloc/registered_courses_bloc.dart';
import 'package:academic_student/core/providers/staff_bloc/staff_bloc.dart';
import 'package:academic_student/core/providers/university_files/cubit/university_file_cubit.dart';
import 'package:academic_student/core/services/fcm_service.dart';
import 'package:academic_student/core/theme/app_theme.dart';
import 'package:academic_student/view/pages/notifications/bloc/notifications_bloc.dart';
import 'package:academic_student/view/pages/schedule/bloc/schedule_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:academic_student/core/providers/about_us_cubit/cubit/about_us_cubit.dart';
import 'package:academic_student/core/providers/banner_cubit/cubit/banner_cubit.dart';
import 'package:academic_student/core/providers/contact_us_cubit/cubit/contact_us_cubit.dart';
import 'package:academic_student/core/providers/country_cubit/cubit/country_cubit.dart';
import 'package:academic_student/core/providers/course_material_cubit/cubit/course_material_cubit.dart';
import 'package:academic_student/core/providers/i18n/localization_provider.dart';
import 'package:academic_student/core/providers/instructor_cubit/cubit/instructor_cubit.dart';
import 'package:academic_student/core/providers/legal_agreements_cubit/cubit/legal_agreement_cubit.dart';
import 'package:academic_student/core/providers/major_cubit/cubit/major_cubit.dart';
import 'package:academic_student/core/providers/payment_method_cubit/cubit/payment_method_cubit.dart';
import 'package:academic_student/core/providers/request_cubit/cubit/request_cubit.dart';
import 'package:academic_student/core/providers/request_type_cubit/cubit/request_type_cubit.dart';
import 'package:academic_student/core/providers/sections_cubit/cubit/sections_cubit.dart';
import 'package:academic_student/core/providers/session_course_cubit/cubit/session_course_cubit.dart';
import 'package:academic_student/core/providers/session_material_cubit/cubit/session_material_cubit.dart';
import 'package:academic_student/core/providers/social_media_groups_cubit/cubit/social_media_groups_cubit.dart';
import 'package:academic_student/core/providers/university_cubit/cubit/university_cubit.dart';
import 'package:academic_student/core/providers/user_bloc/bloc/user_bloc.dart';
import 'package:academic_student/core/services/authentication_service.dart';
import 'package:academic_student/firebase_options.dart';
import 'package:academic_student/utils/i18n/locale_translations.dart';
import 'package:academic_student/utils/routes/generate_routes.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/pages/splash/screen/splash.dart';
import 'package:academic_student/view/shared/screens/custom_error_screen.dart';
import 'package:showcaseview/showcaseview.dart';

Future<void> main() async {
  // usePathUrlStrategy();
  // So we Can use the async/await function for the [SharedPreferences],
  // We add This line

  BindingBase.debugZoneErrorsAreFatal = true;
  // Initializing Sentry for error handeling
  await SentryFlutter.init((options) {
    options.dsn =
        'https://5adfcc74302647ec9ecada5441176536@o4504905206661120.ingest.sentry.io/4504905212100608';
    // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
    // We recommend adjusting this value in production.
    options.tracesSampleRate = 1.0;
  }, appRunner: () async {
    WidgetsFlutterBinding.ensureInitialized();
    final _noScreenshot = NoScreenshot.instance;
    try {
      await _noScreenshot.screenshotOff();
    } catch (e) {
      debugPrint("e : $e");
    }
    // Initializing Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FcmService().initializeFCM();
    FirebaseAuth.instance.setSettings(
      appVerificationDisabledForTesting: false,
      // forceRecaptchaFlow: true,
    );
    // Initializing Localization in DateTime
    await initializeDateFormatting();
    // Initializing SharedPreferences
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (kReleaseMode) {
      FlutterError.onError = (FlutterErrorDetails errorDetails) async {
        await Sentry.captureException(
          errorDetails.exception,
          stackTrace: errorDetails.stack,
        );
      };
    }
    runApp(
      MultiProvider(
        providers: [
          // Initialize Localization Provider
          ChangeNotifierProvider(
            create: (context) => LocalizationProvider(
              Locale(
                sharedPreferences.getString('locale_code') ?? 'en',
              ),
            ),
          ),
          BlocProvider(create: (context) => StaffBloc()),
          BlocProvider(create: (context) => NotificationsBloc()),
          BlocProvider(create: (context) => ScheduleBloc()),
          BlocProvider(create: (context) => BottomNavBarCubit()),
          // Initialize CountryProvider
          BlocProvider(
            create: (context) => CountryCubit(),
          ),
          // Initialize UniversityProvider
          BlocProvider(
            create: (context) => UniversityCubit(),
          ),
          // Initialize BannerProvider
          BlocProvider(
            create: (context) => BannerCubit()..getBanners(),
          ),
          // Initialize Social Media Group Provider
          BlocProvider(
            create: (context) =>
                SocialMediaGroupsCubit()..getSocialMediaGroups(),
          ),
          // Initialize SectionsProvider
          BlocProvider(
            create: (context) => SectionsCubit()..getSections(),
          ),
          // Initialize MajorProvider
          BlocProvider(
            create: (context) => MajorCubit(),
          ),
          // Initialize SettingProvider
          BlocProvider(
            create: (context) => AboutUsCubit(),
          ),
          // Initialize Legal Agreements Provider
          BlocProvider(
            create: (context) => LegalAgreementCubit(),
          ),
          // Initialize All Courses
          BlocProvider(
            create: (context) => SessionCourseCubit(),
          ),
          // Initialize Material Cubit
          BlocProvider(
            create: (context) => SessionMaterialCubit(),
          ),
          // Initialize Material Cubit
          BlocProvider(
            create: (context) => CourseMaterialCubit(),
          ),
          // Initialize Request Type
          BlocProvider(
            create: (context) => RequestTypeCubit()..getRequestTypes(),
          ),
          // Initialize Instructor Cubit
          BlocProvider(
            create: (context) => InstructorCubit()..getInstructors(),
          ),
          // Initialize Request Cubit
          BlocProvider(
            create: (context) => RequestCubit(),
          ),
          // Initilize Contact Us Info Cubit (technical Support)
          BlocProvider(
            create: (context) => ContactUsCubit()..getContactUsInfoData(),
          ),
          // Initilize Footer Data Cubit
          BlocProvider(
            create: (context) => FooterCubit()..getFooterData(),
          ),
          // Initilize PaymentMethod Cubit
          BlocProvider(
            create: (context) => PaymentMethodCubit()..getPaymentMethods(),
          ),

          BlocProvider(
            create: (context) => UniversityFileCubit()..getUniversityFiles(),
          ),
          BlocProvider(
            create: (context) => BookHelpButtonCubit()..getBookHelpButtonData(),
          ),
          BlocProvider(create: (context) => RegisteredCoursesBloc()),
          BlocProvider(create: (context) => RegisteredCourseDetailsBloc()),
          // Initialize User Provider
          BlocProvider(create: (context) {
            // if (kIsWeb) {
            //   return UserBloc(
            //     AuthenticationService(),
            //   );
            // }
            return UserBloc(
              AuthenticationService(),
            )..add(UserAutoLogin());
          }),
        ],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final LocalizationProvider localeProvider =
        Provider.of<LocalizationProvider>(context, listen: false);
    return ShowCaseWidget(
      builder: (context) => GetMaterialApp(
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return CustomError(
              errorDetails: errorDetails,
            );
          };
          return widget!;
        },
        title: 'Academic Student',
        debugShowCheckedModeBanner: false,
        locale: localeProvider.getLocalization, // Choosen Locale
        translations: LocaleTranslations(), // Translations File
        fallbackLocale: const Locale(
            'en'), // If selected Text is not found in the selected local
        onGenerateRoute: RouteGenerator()
            .generateRoute, // Generate Routes [splash, home, ...]
        initialRoute: splashScreenRoute,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
        scrollBehavior: MyCustomScrollBehavior(),
      ),
    );
  }
}

// Enable scrolling with mouse dragging
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
