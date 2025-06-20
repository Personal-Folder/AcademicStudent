import 'package:academic_student/core/models/footer.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaIcon extends StatelessWidget {
  const SocialMediaIcon({super.key, required this.footerData});
  final FooterData footerData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!await launchUrl(
          Uri.parse(footerData.value ?? ""),
          mode: LaunchMode.externalApplication,
        )) {
          CustomDialogs().errorDialog(message: 'Couldn\'t Open Link');
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          "assets/icons/${footerData.type}.svg",
          color: Theme.of(context).colorScheme.primary,
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
