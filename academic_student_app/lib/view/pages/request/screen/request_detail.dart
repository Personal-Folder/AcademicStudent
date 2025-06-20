import 'package:academic_student/core/models/request.dart';
import 'package:academic_student/utils/constants/colors.dart';
import 'package:academic_student/utils/constants/text_design.dart';
import 'package:academic_student/utils/extensions/column_ext.dart';
import 'package:academic_student/utils/routes/routes.dart';
import 'package:academic_student/view/pages/request/widgets/request_detail_notes.dart';
import 'package:academic_student/view/shared/widgets/custom_scaffold_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/request_detail_attachments.dart';

class RequestDetailScreen extends StatelessWidget {
  final RequestModel requestModel;
  const RequestDetailScreen({super.key, required this.requestModel});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: '${requestModel.title} asdas sadas dsd',
      backHome: false,
      redirect: true,
      redirectUrl: requestListScreenRoute,
      pop: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RequestDetailAttachments(
              label: 'student_attachments_field',
              attachments: requestModel.studentAttachments,
            ),
            RequestDetailNotes(
              label: 'student_note_field',
              notes: requestModel.studentNotes,
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              textDirection: TextDirection.rtl,
              children: [
                TableRow(
                  children: [
                    const Icon(
                      Icons.date_range,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      requestModel.deliveryDate,
                      textAlign: TextAlign.start,
                      style: textRequestListStyle,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Icon(
                      Icons.file_copy,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      requestModel.type.name,
                      textAlign: TextAlign.start,
                      style: textRequestListStyle,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const CircleAvatar(
                      backgroundColor: red,
                      radius: 7,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      requestModel.status.name,
                      textAlign: TextAlign.start,
                      style: textRequestListStyle,
                    ),
                  ],
                ),
              ],
            ),
            RequestDetailAttachments(
              label: 'instructor_attachments_field',
              attachments: requestModel.instructorAttachments,
            ),
            RequestDetailNotes(
              label: 'instructor_note_field',
              notes: requestModel.instructorNotes,
            ),
          ],
        ).applyPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
        ),
      ),
    );
  }
}
