import 'package:academic_student/core/models/university_file.dart';
import 'package:academic_student/core/models/user.dart';
import 'package:academic_student/utils/helpers/dialogs.dart';
import 'package:academic_student/view/shared/widgets/pdf_view_attachments.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UniveristyFileWidget extends StatelessWidget {
  const UniveristyFileWidget({required this.universityFile, super.key});
  final UniversityFile universityFile;
  openEnrollment(
      {required String url,
      required String title,
      required BuildContext context}) async {
    if (url.contains('pdf')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfViewAttachment(
            title: title,
            url: url,
          ),
        ),
      );
    } else {
      if (!await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      )) {
        CustomDialogs().errorDialog(message: 'Couldn\'t Open Link');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      onTap: () async {
        if (!universityFile.link.contains(".pdf")) {
          if (!await launchUrl(
            Uri.parse(universityFile.link),
            mode: LaunchMode.externalApplication,
          )) {
            CustomDialogs().errorDialog(message: 'error');
          }
        } else {
          openEnrollment(
              title: universityFile.title,
              url: "${universityFile.link}?token=${User.token}",
              context: context);
        }
      },
      leading: universityFile.link.contains(".pdf")
          ? Image.asset(
              "assets/images/academic-student/pdf.png",
              width: 50,
              height: 50,
            )
          : const SizedBox(
              width: 50, height: 50, child: Icon(Icons.language_rounded)),
      title: Text(
        universityFile.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: ElevatedButton(
        onPressed: () async {
          if (kIsWeb) {
            if (!await launchUrl(
              Uri.parse(universityFile.link),
              mode: LaunchMode.externalApplication,
            )) {
              CustomDialogs().errorDialog(message: 'error');
            }
          } else {
            openEnrollment(
                title: universityFile.title,
                url: "${universityFile.link}?token=${User.token}",
                context: context);
          }
        },
        child: Text("open".tr),
      ),
    ));
  }
}
