import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/pages/home/widgets/join_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/session_course.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_design.dart';

class SessionCourseWidget extends StatelessWidget {
  final SessionCourse sessionCourse;
  const SessionCourseWidget({
    super.key,
    required this.sessionCourse,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed(
            "$sessionCourseDetailScreenRoute?id=${sessionCourse.id}",
            arguments: sessionCourse.id);
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
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
                            sessionCourse.name,
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
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            width: double.infinity,
                            child: AutoSizeText(
                              sessionCourse.description,
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        if (sessionCourse.schedule.first['day'] != "")
                          AutoSizeText(
                            sessionCourse.schedule.first['day'],
                            maxLines: 1,
                            style: textCourseDateStyle,
                          ),
                        if (sessionCourse.schedule.first['time_from'] != "")
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: AutoSizeText(
                                DateFormat("h:mm a").format(
                                    DateFormat("H:mm:ss").parse(sessionCourse
                                        .schedule.first['time_from'])),
                                maxLines: 1,
                                style: GoogleFonts.tajawal(
                                  color: white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        if (sessionCourse.schedule.last['day'] != "")
                          AutoSizeText(
                            sessionCourse.schedule.last['day'],
                            maxLines: 1,
                            style: textCourseDateStyle,
                          ),
                        if (sessionCourse.schedule.last['time_from'] != "")
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: AutoSizeText(
                                DateFormat("h:mm a").format(
                                    DateFormat("H:mm:ss").parse(sessionCourse
                                        .schedule.last['time_from'])),
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.tajawal(
                                  color: white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            JoinButton(
              title: 'join',
              onPressed: () {
                Navigator.of(context).pushNamed(
                    "$sessionCourseDetailScreenRoute?id=${sessionCourse.id}",
                    arguments: sessionCourse.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
