import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:academic_student/view/pages/home/widgets/join_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/models/social_media_groups.dart';
import '../../../../utils/constants/text_design.dart';

class WhatsappGroupListWidget extends StatelessWidget {
  final SocialMediaGroup whatsappGroup;
  const WhatsappGroupListWidget({
    super.key,
    required this.whatsappGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          whatsappGroup.image == null
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
                    // cacheHeight: 50,
                    // cacheWidth: 50,
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
                        // cacheHeight: 50,
                        // cacheWidth: 50,
                      ),
                    ),
          AutoSizeText(
            whatsappGroup.title,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: textWhatsappGroupTitleStyle,
          ),
          JoinButton(
            title: 'join',
            onPressed: () async {
              if (!await launchUrl(
                Uri.parse(whatsappGroup.link),
                mode: LaunchMode.externalApplication,
              )) {
                CustomDialogs()
                    .errorDialog(message: 'Couldn\'t Join the group');
              }
            },
          ),
        ],
      ),
    );
  }
}
