import 'package:academic_student/core/models/registered_course.dart';
import 'package:academic_student/core/models/request.dart';
import 'package:academic_student/core/models/section.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/pages/aboutUs/screen/about_us.dart';
import 'package:academic_student/view/pages/authentication/screen/login.dart';
import 'package:academic_student/view/pages/authentication/screen/otp_success.dart';
import 'package:academic_student/view/pages/authentication/screen/otp_verification.dart';
import 'package:academic_student/view/pages/authentication/screen/register.dart';
import 'package:academic_student/view/pages/authentication/screen/reset_password.dart';
import 'package:academic_student/view/pages/paymentMethod/screen/payment_method.dart';
import 'package:academic_student/view/pages/request/screen/request_detail.dart';
import 'package:academic_student/view/pages/request/screen/request_list.dart';
import 'package:academic_student/view/pages/sessionCourseDetail/screen/session_course_detail.dart';
import 'package:academic_student/view/pages/technicalSupport/screen/technical_support.dart';
import 'package:academic_student/view/pages/sessionCourse/screen/session_courses.dart';
import 'package:academic_student/view/pages/majors/screen/majors.dart';
import 'package:academic_student/view/pages/privacyPolicy/screen/privacy_policy.dart';
import 'package:academic_student/view/pages/profile/screen/profile.dart';
import 'package:academic_student/view/pages/request/screen/add_request.dart';
import 'package:academic_student/view/pages/sections/screen/sections.dart';
import 'package:academic_student/view/pages/splash/screen/splash.dart';
import 'package:academic_student/view/pages/termsConditions/screen/terms_condition.dart';
import 'package:academic_student/view/pages/whatsapp/screen/whatsapp.dart';
import 'package:flutter/material.dart';

import '../../view/pages/home/screen/home.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    Uri fullPath = Uri.parse(settings.name!);
    switch (fullPath.path) {
      case splashScreenRoute:
        return MaterialPageRoute(
            builder: (_) => const SplashScreen(),
            settings: const RouteSettings(
              name: splashScreenRoute,
            ));
      case loginScreenRoute:
        return MaterialPageRoute(
            builder: (_) => const LoginScreen(),
            settings: const RouteSettings(
              name: loginScreenRoute,
            ));
      case registerScreenRoute:
        return MaterialPageRoute(
            builder: (_) => const RegisterScreen(),
            settings: const RouteSettings(
              name: registerScreenRoute,
            ));
      case otpVerificationRoute:
        final Map mapValue = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => OTPVerificationScreen(
                  countryCode: mapValue['country_code'] ?? '',
                  phoneNumber: mapValue['phone_number'] ?? '',
                  email: mapValue['email'] ?? '',
                ),
            settings: const RouteSettings(
              name: otpVerificationRoute,
            ));
      case otpSuccessRoute:
        return MaterialPageRoute(
            builder: (context) => const OTPSuccessScreen(),
            settings: const RouteSettings(
              name: otpSuccessRoute,
            ));

      case resetPasswordRoute:
        return MaterialPageRoute(
            builder: (context) => const ResetPasswordScreen(),
            settings: const RouteSettings(
              name: resetPasswordRoute,
            ));
      case homeScreenRoute:
        return MaterialPageRoute(
            builder: (context) =>
                HomeScreen(refresh: (settings.arguments as bool?) ?? false),
            settings: const RouteSettings(
              name: homeScreenRoute,
            ));
      case sectionsScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const SectionScreen(),
            settings: const RouteSettings(
              name: sectionsScreenRoute,
            ));
      case majorsScreenRoute:
        if (fullPath.queryParameters.isNotEmpty) {
          return MaterialPageRoute(
            builder: (context) => MajorScreen(
              section: (settings.arguments as Section),
            ),
            settings: RouteSettings(
              name:
                  "$majorsScreenRoute?sectionId=${fullPath.queryParameters['sectionId']!}",
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(refresh: true),
        );
      case sessionCoursesScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const SessionCoursesScreen(),
            settings: const RouteSettings(
              name: sessionCoursesScreenRoute,
            ));
      case aboutUsScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const AboutUsScreen(),
            settings: const RouteSettings(
              name: aboutUsScreenRoute,
            ));

      case requestListScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const RequestListScreen(),
            settings: const RouteSettings(
              name: registerScreenRoute,
            ));

      case requestDetailScreenRoute:
        if (settings.arguments != null && settings.arguments is RequestModel) {
          return MaterialPageRoute(
            builder: (context) => RequestDetailScreen(
              requestModel: settings.arguments as RequestModel,
            ),
            settings: RouteSettings(
              name:
                  "$requestDetailScreenRoute/${(settings.arguments as RequestModel).id}",
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const RequestListScreen(),
        );

      case addRequestScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const AddRequestScreen(),
          settings: const RouteSettings(
            name: addRequestScreenRoute,
          ),
        );

      case privacyPolicyScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const PrivacyPolicyScreen(),
          settings: const RouteSettings(
            name: privacyPolicyScreenRoute,
          ),
        );
      case termsConditionsScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const TermsConditionScreen(),
          settings: const RouteSettings(
            name: termsConditionsScreenRoute,
          ),
        );
      case profileScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
          settings: const RouteSettings(
            name: profileScreenRoute,
          ),
        );

      case courseMaterialScreenRoute:
        if (fullPath.queryParameters.isNotEmpty) {}
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(refresh: true),
        );
      case sessionMaterialScreenRoute:
        if (fullPath.queryParameters.isNotEmpty) {
          // return MaterialPageRoute(
          //   builder: (context) => SessionMaterialsScreen(
          //     courseMaterialId:
          //         int.parse(fullPath.queryParameters['courseMaterialId']!),
          //     arguments: [
          //       int.parse(fullPath.queryParameters['sectionId']!),
          //       int.parse(fullPath.queryParameters['majorId']!)
          //     ],
          //   ),
          //   settings: RouteSettings(
          //     name:
          //         "$sessionMaterialScreenRoute?sectionId=${fullPath.queryParameters['sectionId']!}&majorId=${fullPath.queryParameters['majorId']!}&courseMaterialId=${fullPath.queryParameters['courseMaterialId']!}",
          //   ),
          // );
        }
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(refresh: true),
        );
      case sessionMaterialDetailScreenRoute:
      // if (fullPath.queryParameters.isNotEmpty) {
      //   return MaterialPageRoute(
      //     builder: (context) => SessionMaterialDetail(
      //       sessionMaterialId: int.parse(fullPath.queryParameters['id']!),
      //     ),
      //     settings: RouteSettings(
      //       name:
      //           "$sessionMaterialDetailScreenRoute?id=${fullPath.queryParameters['id']}",
      //     ),
      //   );
      // }
      // return MaterialPageRoute(
      //   builder: (context) => const HomeScreen(refresh: true),
      // );
      case sessionCourseDetailScreenRoute:
        if (fullPath.queryParameters.isNotEmpty) {
          return MaterialPageRoute(
            builder: (context) => SessionCourseDetail(
              // sessionCourseId: int.parse(fullPath.queryParameters['id']!),
              course: RegisteredCourse(id: settings.arguments as int?),
            ),
            settings: RouteSettings(
              name:
                  "$sessionCourseDetailScreenRoute?id=${fullPath.queryParameters['id']}",
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(refresh: true),
        );

      case technicalSupportScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const TechnicalSupportScreen(),
          settings: const RouteSettings(
            name: technicalSupportScreenRoute,
          ),
        );

      case whatsappSocialMediaScreenRoute:
        return MaterialPageRoute(
          builder: (context) => const WhatsappScreen(),
          settings: const RouteSettings(
            name: whatsappSocialMediaScreenRoute,
          ),
        );

      case paymentMethodScreenRoute:
        if (settings.arguments != null) {
          return MaterialPageRoute(
            builder: (context) => PaymentMethodScreen(
              sessionId: (settings.arguments as List)[0] as int,
              subscriptionTypeId: (settings.arguments as List)[1] as int,
            ),
            settings: RouteSettings(
              name:
                  "$paymentMethodScreenRoute/${((settings.arguments as List)[0] as int)}/${((settings.arguments as List)[1] as int)}",
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(refresh: true),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
