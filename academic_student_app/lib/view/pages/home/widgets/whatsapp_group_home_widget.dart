import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_network/image_network.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:academic_student/utils/helpers/dialogs.dart';

import '../../../../core/models/social_media_groups.dart';

class WhatsappWidget extends StatelessWidget {
  final SocialMediaGroup whatsappGroup;
  const WhatsappWidget({
    Key? key,
    required this.whatsappGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      onTap: () async {
        if (!await launchUrl(
          Uri.parse(whatsappGroup.link),
          mode: LaunchMode.externalApplication,
        )) {
          CustomDialogs().errorDialog(message: 'Couldn\'t Join the group');
        }
      },
      leading: whatsappGroup.image!.isEmpty
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                'assets/images/whatsapp-logo.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            )
          : kIsWeb
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: ImageNetwork(
                    image: whatsappGroup.image ?? '',
                    height: 50,
                    width: 50,
                    borderRadius: BorderRadius.circular(90),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    whatsappGroup.image ?? '',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
      title: Text(
        whatsappGroup.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: ElevatedButton(
        onPressed: () async {
          if (!await launchUrl(
            Uri.parse(whatsappGroup.link),
            mode: LaunchMode.externalApplication,
          )) {
            CustomDialogs().errorDialog(message: 'Couldn\'t Join the group');
          }
        },
        child: Text("join".tr),
      ),
    ));
  }
}
