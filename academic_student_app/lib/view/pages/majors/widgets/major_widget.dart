import 'package:academic_student/core/models/major.dart';
import 'package:academic_student/core/models/section.dart';
import 'package:academic_student/view/pages/courseMaterial/screen/course_materials.dart';
import 'package:flutter/material.dart';

class MajorWidget extends StatelessWidget {
  final Major major;
  final Section section;
  const MajorWidget({super.key, required this.major, required this.section});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CourseMaterialsScreen(section: section, major: major)));
        },
        title: Text(major.title),
      ),
    );
  }
}
