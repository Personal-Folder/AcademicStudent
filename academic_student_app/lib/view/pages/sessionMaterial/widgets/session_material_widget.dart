import 'package:academic_student/core/models/session_material.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/pages/home/widgets/join_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/colors.dart';

class SessionMaterialWidget extends StatelessWidget {
  final SessionMaterial sessionMaterial;
  const SessionMaterialWidget({
    super.key,
    required this.sessionMaterial,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed("$sessionMaterialDetailScreenRoute?id=${sessionMaterial.id}", arguments: sessionMaterial.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: AutoSizeText(
                      sessionMaterial.name,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.tajawal(
                        color: primaryColor,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: AutoSizeText(
                        sessionMaterial.description,
                        textAlign: TextAlign.justify,
                        maxLines: 7,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  JoinButton(
                    title: 'join',
                    onPressed: () {
                      Navigator.of(context).pushNamed("$sessionMaterialDetailScreenRoute?id=${sessionMaterial.id}", arguments: sessionMaterial.id);
                    },
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   width: 15,
            // ),
            // Flexible(
            //   flex: 1,
            //   child: Column(
            //     children: [
            //       Container(
            //         height: 50,
            //         width: 50,
            //         decoration: BoxDecoration(
            //           color: primaryColor,
            //           borderRadius: BorderRadius.circular(15),
            //         ),
            //       ),
            //       AutoSizeText(
            //         sessionMaterial.schedule.first['day'],
            //         maxLines: 1,
            //         style: textCourseDateStyle,
            //       ),
            //       Container(
            //         padding: const EdgeInsets.all(2),
            //         decoration: BoxDecoration(
            //           color: grey,
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         child: AutoSizeText(
            //           DateFormat("h:mm a").format(DateFormat("H:mm:ss").parse(sessionMaterial.schedule.first['time_from'])),
            //           maxLines: 1,
            //           style: GoogleFonts.tajawal(
            //             color: white,
            //             fontSize: 12,
            //           ),
            //         ),
            //       ),
            //       AutoSizeText(
            //         sessionMaterial.schedule.last['day'],
            //         maxLines: 1,
            //         style: textCourseDateStyle,
            //       ),
            //       Container(
            //         padding: const EdgeInsets.all(2),
            //         decoration: BoxDecoration(
            //           color: grey,
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         child: AutoSizeText(
            //           DateFormat("h:mm a").format(DateFormat("H:mm:ss").parse(sessionMaterial.schedule.last['time_from'])),
            //           maxLines: 1,
            //           textAlign: TextAlign.right,
            //           style:  GoogleFonts.tajawal(
            //             color: white,
            //             fontSize: 12,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
