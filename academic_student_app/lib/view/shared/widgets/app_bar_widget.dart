import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/display_size.dart';
import 'package:academic_student/utils/constants/services.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? backHome;
  final bool? redirect;
  final bool? pop;
  final String? redirectUrl;
  final Object? arguments;
  const AppBarWidget({
    super.key,
    this.backHome,
    this.redirect,
    this.redirectUrl,
    this.arguments,
    required this.title,
    this.pop,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: primaryColor,
      foregroundColor: white,
      actions: (ModalRoute.of(context)!.settings.name == '/home')
          ? [
              IconButton(
                tooltip: 'Go To Website',
                onPressed: () async {
                  if (!await launchUrl(
                    Uri.parse(websiteUrl),
                    mode: LaunchMode.externalApplication,
                  )) {
                    CustomDialogs().errorDialog(message: 'Couldn\'t Launch Url');
                  }
                },
                icon: const Icon(
                  Icons.language,
                ),
              ),
            ]
          : null,
      title: Directionality(
        textDirection: Get.locale!.languageCode == 'ar' ? TextDirection.ltr : TextDirection.rtl,
        child: ((backHome ?? false) ^ (redirect ?? false)) || (pop ?? false)
            ? Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (backHome ?? false) {
                        Navigator.of(context).pushNamedAndRemoveUntil(homeScreenRoute, ModalRoute.withName('/home'));
                      } else if (redirectUrl != null && (redirect ?? false)) {
                        Navigator.of(context).pushReplacementNamed(redirectUrl!, arguments: arguments);
                      } else if (pop ?? false) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  // const Spacer(),
                  Expanded(
                    child: AutoSizeText(
                      title.tr,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.tajawal(
                        color: white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // const Spacer()
                ],
              )
            : AutoSizeText(
                title.tr,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: GoogleFonts.tajawal(
                  color: white,
                  fontSize: 16,
                ),
              ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}
