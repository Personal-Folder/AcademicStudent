import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/text_design.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/routes/routes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      elevation: 1,
      child: ListView(
        padding: const EdgeInsets.only(
          top: 70,
        ),
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(sectionsScreenRoute);
            },
            title: Text(
              'sections'.tr,
              style: textDrawerItemStyle,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(sessionCoursesScreenRoute);
            },
            title: Text(
              'courses'.tr,
              style: textDrawerItemStyle,
            ),
          ),

          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.of(context).pushReplacementNamed(addRequestScreenRoute);
          //   },
          //   title: Text(
          //     'online_request'.tr,
          //     style: textDrawerItemStyle,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.of(context).pushReplacementNamed(requestListScreenRoute);
          //   },
          //   title: Text(
          //     'request_list'.tr,
          //     style: textDrawerItemStyle,
          //   ),
          // ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(profileScreenRoute);
            },
            title: Text(
              'profile'.tr,
              style: textDrawerItemStyle,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(aboutUsScreenRoute);
            },
            title: Text(
              'about_us'.tr,
              style: textDrawerItemStyle,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(termsConditionsScreenRoute);
            },
            title: Text(
              'terms_conditions'.tr,
              style: textDrawerItemStyle,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(privacyPolicyScreenRoute);
            },
            title: Text(
              'privacy_policy'.tr,
              style: textDrawerItemStyle,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(technicalSupportScreenRoute);
            },
            title: Text(
              'technical_support'.tr,
              style: textDrawerItemStyle,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(whatsappSocialMediaScreenRoute);
            },
            title: Text(
              'whatsapp'.tr,
              style: textDrawerItemStyle,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              CustomDialogs().switchLanguage();
            },
            title: Text(
              'switch_language'.tr,
              style: textDrawerItemStyle,
            ),
          )
        ],
      ),
    );
  }
}
