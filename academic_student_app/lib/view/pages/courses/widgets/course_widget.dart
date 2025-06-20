import 'package:academic_student/core/models/registered_course.dart';
import 'package:academic_student/core/models/session_course.dart';
import 'package:academic_student/view/pages/sessionCourseDetail/screen/session_course_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CourseWidget extends StatelessWidget {
  final SessionCourse sessionCourse;
  const CourseWidget({super.key, required this.sessionCourse});

  @override
  Widget build(BuildContext context) {
    String schedule = "";
    if (sessionCourse.schedule.first['day'] != "") {
      schedule += "${sessionCourse.schedule.first['day']} ";
    }
    if (sessionCourse.schedule.first['time_from'] != "") {
      schedule +=
          "${DateFormat("h:mm a").format(DateFormat("H:mm:ss").parse(sessionCourse.schedule.first['time_from']))} ";
    }
    if (sessionCourse.schedule.last['day'] != "") {
      schedule += "-> ${sessionCourse.schedule.last['day']} ";
    }
    if (sessionCourse.schedule.last['time_from'] != "") {
      schedule +=
          "${DateFormat("h:mm a").format(DateFormat("H:mm:ss").parse(sessionCourse.schedule.last['time_from']))} ";
    }

    return Card(
        child: ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SessionCourseDetail(
                    course: RegisteredCourse(
                        name: sessionCourse.name,
                        id: sessionCourse.id,
                        code: sessionCourse.code))));
      },
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        radius: 25,
        child: Text(
          sessionCourse.code.trim()[0].toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.montserrat(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
      title: Text(
        sessionCourse.name,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.tajawal(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '${sessionCourse.description}\n$schedule',
        maxLines: 7,
        overflow: TextOverflow.ellipsis,
      ),
    ));
  }
}
