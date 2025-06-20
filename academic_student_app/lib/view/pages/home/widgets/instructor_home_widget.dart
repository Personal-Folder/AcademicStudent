import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/instructor.dart';
import '../../../../utils/constants/text_design.dart';

class InstructorHomeWidget extends StatelessWidget {
  final Instructor instructor;
  const InstructorHomeWidget({
    Key? key,
    required this.instructor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          // instructor.avatar == null
          //     ?
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              'assets/images/unkown_profile_icon.png',
              height: 75,
              width: 75,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          AutoSizeText(
            instructor.name ?? "",
            maxLines: 2,
            wrapWords: false,
            textAlign: TextAlign.center,
            style: textDoctorNameStyle,
          ),
        ],
      ),
    );
  }
}
